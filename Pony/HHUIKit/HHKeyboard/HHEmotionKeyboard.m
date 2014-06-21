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

#define HH_EXP_COUNT        84
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
        
        UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *path = [bundle stringByAppendingPathComponent:@"VoiceInputBtn_ios7@2x.png"];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        [sendButton setBackgroundImage:img forState:UIControlStateNormal];
//        path = [bundle stringByAppendingPathComponent:@"del_emoji_s.png"];
//        img = [UIImage imageWithContentsOfFile:path];
//        [sendButton setImage:img forState:UIControlStateSelected];
//        [sendButton setTitle:@"Send" forState:UIControlStateNormal];
//        sendButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        NSDictionary *attr = @{NSFontAttributeName: [UIFont fontWithName:@"Courier-Oblique" size:14.f]};
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"发送"
                                                                  attributes:attr];
        [sendButton setAttributedTitle:str forState:UIControlStateNormal];
//        SEL action = @selector(__pressDelbutton:);
        SEL action = @selector(__pressSendButton:);
        [sendButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        sendButton.frame = CGRectMake(252.f, 182.f, 70.f, 34.f);
        [self addSubview:sendButton];
        
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
    CGFloat width = (HH_EXP_COUNT / HH_EXP_PAGE_COUNT) * 320.f;
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
            btn.exclusiveTouch = YES;
            [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
            NSInteger pMod = i % HH_EXP_PAGE_COUNT;
            NSInteger p = (i - 1) / HH_EXP_PAGE_COUNT;
            
            if (pMod == 0) {
                btn.tag = 10001;
                fileName = [NSString stringWithFormat:@"del_emoji_n.png"];
            } else {
                btn.tag = i;
                fileName = [NSString stringWithFormat:@"%03d.png", i];
            }
            pMod = (i - 1) % HH_EXP_PAGE_COUNT;
            
            CGFloat x = (pMod % HH_EXP_CLU_COUNT) * HH_EXP_SIZE + 6 + (p * 320);
            CGFloat y = (((i - 1) % HH_EXP_PAGE_COUNT) / HH_EXP_CLU_COUNT) * HH_EXP_SIZE + 8;
            btn.frame = CGRectMake( x, y, HH_EXP_SIZE, HH_EXP_SIZE);
            
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
    NSRange range = self.textView.selectedRange;
    if (text.length && (range.location != 0) ) {
        range.location -= 1;
        range.length = 1;
        NSMutableString *finalText = [NSMutableString stringWithString:text];
        NSInteger textLength = range.location + 1;
        if (textLength >= HH_EXP_NAME_LENGTH) {
            NSString *tmpText = [text substringFromIndex:textLength - HH_EXP_NAME_LENGTH];
            NSRange expRange = [tmpText rangeOfString:HH_EXP_HEAD];
            if (expRange.location == 0) {
                range.location -= (HH_EXP_NAME_LENGTH - 1);
                range.length = HH_EXP_NAME_LENGTH;
                [finalText deleteCharactersInRange:range];
            } else {
                [finalText deleteCharactersInRange:range];
            }
        } else {
            [finalText deleteCharactersInRange:range];
        }
        
        self.textView.text = finalText;
        range.length = 0;
        self.textView.selectedRange = range;
        if ([self.textView.delegate respondsToSelector:@selector(textViewDidChange:)]) {
            [self.textView.delegate textViewDidChange:self.textView];
        }
    }
}

- (void)__pressExpressionButton:(id)sender
{
    if (self.textView) {
        NSInteger i = ((UIButton *)sender).tag;
        if (i == 10001) {
            [self __pressDelbutton:sender];
            return;
        }
        
        NSMutableString *text = [[NSMutableString alloc] initWithString:self.textView.text];
#if __LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE) || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64
        NSString *expressionText = [NSString stringWithFormat:@"%@%03ld", HH_EXP_HEAD, i];
#else
        NSString *expressionText = [NSString stringWithFormat:@"%@%03d", HH_EXP_HEAD, i];
#endif
        NSUInteger loc = self.textView.selectedRange.location;
        [text insertString:expressionText atIndex:loc];
        self.textView.text = text;
        self.textView.selectedRange = NSMakeRange(loc + expressionText.length, 0);
        if ([self.textView.delegate respondsToSelector:@selector(textViewDidChange:)]) {
            [self.textView.delegate textViewDidChange:self.textView];
        }
    }
}

- (void)__pressSendButton:(id)sender
{
    if (!self.textView) {
        return;
    }
    
    SEL sel = @selector(textView:shouldChangeTextInRange:replacementText:);
    if ([self.textView.delegate respondsToSelector:sel]) {
        [self.textView.delegate textView:self.textView
                 shouldChangeTextInRange:NSMakeRange(0, 0)
                         replacementText:@"\n"];
    }
}

@end
