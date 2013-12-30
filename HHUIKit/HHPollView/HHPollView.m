//
//  HHPollView.m
//
//  Copyright (c) 2013 Wanqiang Ji
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "HHPollView.h"

#if ! __has_feature(objc_arc)
	#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

@interface HHPollView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSUInteger numberOfPages;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *currentViews;

@end

@implementation HHPollView

- (void)dealloc
{
	self.currentViews = nil;
	[self endAutoRun];
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	if (self)
	{
		[self initialize];
	}
	
	return self;
}

- (void)awakeFromNib
{
	[super awakeFromNib];
	[self initialize];
}

#pragma mark - Private Methods
- (void)initialize
{
	_scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
	_scrollView.delegate = self;
	_scrollView.pagingEnabled = YES;
	_scrollView.showsHorizontalScrollIndicator = NO;
	_scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
	_scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
	[self addSubview:_scrollView];
}

- (void)autoScroll
{
	[_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * 2, 0) animated:YES];
}

- (void)resetTimerState
{
	if ([_timer isValid])
	{
		[_timer invalidate];
	}
	else
	{
		[self beginAutoRun];
	}
}

- (void)removeSubviewsOfSuper:(UIView*)view
{
	if (view.subviews.count != 0)
	{
		[view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
	}
}

- (void)loadData
{
	if ([_delegate respondsToSelector:@selector(pollView:didChangeItemAtIndex:)])
	{
		[_delegate pollView:self didChangeItemAtIndex:_currentIndex];
	}
	
	[self removeSubviewsOfSuper:_scrollView];
	
	[self getDisplayContentsWithCurpage:_currentIndex];
	
	@autoreleasepool
	{
		for (int i = 0; i < 3; i++)
		{
			UIView *v = self.currentViews[i];
			v.userInteractionEnabled = YES;
			
			UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
			[v addGestureRecognizer:singleTap];
			
			v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
			[_scrollView addSubview:v];
		}
	}
	
	[_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

- (void)getDisplayContentsWithCurpage:(NSUInteger)page
{
	int pre = [self validPageValue:_currentIndex - 1];
	int last = [self validPageValue:_currentIndex + 1];
	
	if (!self.currentViews)
	{
		self.currentViews = [NSMutableArray array];
	}
	else
	{
		[self.currentViews removeAllObjects];
	}

	[self.currentViews addObject:[_dataSource pageAtIndex:pre]];
	[self.currentViews addObject:[_dataSource pageAtIndex:page]];
	[self.currentViews addObject:[_dataSource pageAtIndex:last]];
}

- (int)validPageValue:(NSInteger)value
{
	if(value == -1)
	{
		value = self.numberOfPages - 1;
	}
	else if(value == self.numberOfPages)
	{
		value = 0;
	}
	
	return value;
}

- (void)handleTap:(UITapGestureRecognizer *)tap
{
	if (tap.state == UIGestureRecognizerStateEnded)
	{
		if ([_delegate respondsToSelector:@selector(pollView:didSelectItemAtIndex:)])
		{
			[_delegate pollView:self didSelectItemAtIndex:_currentIndex];
		}
	}
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	if (self.timer)
	{
		[self resetTimerState];
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	if (self.timer)
	{
		[self resetTimerState];
	}
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	int x = scrollView.contentOffset.x;
	
	//next page
	if(x >= (2*self.frame.size.width))
	{
		_currentIndex = [self validPageValue:_currentIndex+1];
		[self loadData];
	}
	
	//pre page
	if(x <= 0)
	{
		_currentIndex = [self validPageValue:_currentIndex-1];
		[self loadData];
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	[_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:YES];
}

#pragma mark - Public Methods
- (void)reloadData
{
	self.numberOfPages = [_dataSource numberOfPages];
	if (self.numberOfPages != 0)
	{
		_currentIndex = 0;
		[self loadData];
	}
}

- (BOOL)beginAutoRun
{
	[self endAutoRun];
	self.timer = [NSTimer timerWithTimeInterval:_timerInterval target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
	if (self.timer)
	{
		[[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
		return YES;
	}
	
	return NO;
}

- (BOOL)endAutoRun
{
	if ([self.timer isValid])
	{
		[self.timer invalidate];
	}
	self.timer = nil;
	return YES;
}

@end
