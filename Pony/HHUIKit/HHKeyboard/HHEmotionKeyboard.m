//
//  HHEmotionKeyboard.m
//
//  Copyright (c) 2014 Wanqiang Ji
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

#import "HHEmotionKeyboard.h"

#ifndef RGB
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define HEX(c)       [UIColor colorWithRed:((c>>16)&0xFF)/255.0\
                                     green:((c>>8)&0xFF)/255.0\
                                      blue:(c&0xFF)/255.0\
                                     alpha:1.0]
#endif

#define HH_EXP_COUNT        85
#define HH_EXP_SIZE         44.f
#define HH_EXP_HEAD         @"/s"
#define HH_EXP_ROW_COUNT    4
#define HH_EXP_CLU_COUNT    7
#define HH_EXP_NAME_LENGTH  5
#define HH_EXP_PAGE_COUNT   (HH_EXP_ROW_COUNT * HH_EXP_CLU_COUNT)

@interface HHEmotionKeyboard () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *expressionView;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation HHEmotionKeyboard

- (id)init
{
	self = [super init];
	
	if (self) {
		self.frame = CGRectMake(0.f, 0.f, 320.f, 216.f);
        self.backgroundColor = HEX(0xd5d7da);
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"HHEmotionKeyboard"
                                                           ofType:@"bundle"];

        CGRect frame = CGRectMake(0.f, 0.f, 320.f, 190.f);
        self.expressionView = [[UIScrollView alloc] initWithFrame:frame];
        self.expressionView.delegate = self;
        self.expressionView.pagingEnabled = YES;
        self.expressionView.showsVerticalScrollIndicator = NO;
        self.expressionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.expressionView];
        
        frame = CGRectMake(110.f, 190.f, 100.f, 20.f);
        self.pageControl = [[UIPageControl alloc] initWithFrame:frame];
        [self addSubview:self.pageControl];
        
        UIButton *delButton = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *path = [bundle stringByAppendingPathComponent:@"del_emoji_n.png"];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        [delButton setImage:img forState:UIControlStateNormal];
        path = [bundle stringByAppendingPathComponent:@"del_emoji_s.png"];
        img = [UIImage imageWithContentsOfFile:path];
        [delButton setImage:img forState:UIControlStateSelected];
        SEL action = @selector(__pressDelbutton:);
        [delButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        delButton.frame = CGRectMake(272.f, 182.f, 38.f, 28.f);
        [self addSubview:delButton];
        
        [self __layoutExpressions];
	}
	
	return self;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.pageControl setCurrentPage:scrollView.contentOffset.x / 320.f];
    [self.pageControl updateCurrentPageDisplay];
}

#pragma mark - Public Methods
+ (HHEmotionKeyboard *)standardEmotionKeyboard
{
    static HHEmotionKeyboard *__standardKeyboard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __standardKeyboard = [HHEmotionKeyboard new];
    });
    return __standardKeyboard;
}

- (void)deleteOperate
{
    [self __pressDelbutton:nil];
}

#pragma mark - Private Methods
- (void)__layoutExpressions
{
    CGFloat width = (HH_EXP_COUNT / HH_EXP_PAGE_COUNT + 1) * 320.f;
    self.pageControl.numberOfPages = width / 320.f;
    self.expressionView.contentSize = CGSizeMake(width,
                                                 CGRectGetHeight(self.expressionView.bounds));
    NSString *bundle = [[NSBundle mainBundle] pathForResource:@"HHEmotionKeyboard"
                                                       ofType:@"bundle"];
    NSString *fileName, *path;
    UIImage *img;
    UIButton *btn;
    SEL action = @selector(__pressExpressionButton:);
    for (int i = 1; i <= HH_EXP_COUNT; i++) {
        @autoreleasepool {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i;
            btn.exclusiveTouch = YES;
            [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
            NSInteger pMod = ((i - 1) % HH_EXP_PAGE_COUNT);
            NSInteger p = ((i - 1) / HH_EXP_PAGE_COUNT);
            CGFloat x = (pMod % HH_EXP_CLU_COUNT) * HH_EXP_SIZE + 6 + (p * 320);
            CGFloat y = (((i - 1) % HH_EXP_PAGE_COUNT) / HH_EXP_CLU_COUNT) * HH_EXP_SIZE + 8;
            btn.frame = CGRectMake( x, y, HH_EXP_SIZE, HH_EXP_SIZE);
            
            fileName = [NSString stringWithFormat:@"%03d.png", i];
            path = [bundle stringByAppendingPathComponent:fileName];
            img = [UIImage imageWithContentsOfFile:path];
            [btn setImage:img forState:UIControlStateNormal];
            [self.expressionView addSubview:btn];
        }
    }
}

- (void)__pressDelbutton:(id)sender
{
    NSString *text = self.textView.text;
    if (text.length) {
        NSString *finalText;
        NSInteger textLength = text.length;
        if (textLength >= HH_EXP_NAME_LENGTH) {
            finalText = [text substringFromIndex:textLength - HH_EXP_NAME_LENGTH];
            NSRange range = [finalText rangeOfString:HH_EXP_HEAD];
            if (range.location == 0) {
                NSRange range = [text rangeOfString:HH_EXP_HEAD options:NSBackwardsSearch];
                finalText = [text substringToIndex:range.location];
            } else {
                finalText = [text substringToIndex:textLength - 1];
            }
        } else {
            finalText = [text substringToIndex:textLength - 1];
        }
        
        if (self.textView) {
            self.textView.text = finalText;
        }
    }
}

- (void)__pressExpressionButton:(id)sender
{
    if (self.textView) {
        int i = ((UIButton *)sender).tag;
        NSMutableString *text = [[NSMutableString alloc] initWithString:self.textView.text];
        NSString *expressionText = [NSString stringWithFormat:@"%@%03d", HH_EXP_HEAD, i];
        [text appendString:expressionText];
        self.textView.text = text;
    }
}

@end
