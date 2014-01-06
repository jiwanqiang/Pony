//
//  UIView+Shake.m
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

#if __has_feature(objc_arc)
	#error This file must be compiled with MRC. Use -fno-objc-arc flag (or convert project to ARC).
#endif

#import "UIView+Shake.h"
#import <objc/runtime.h>

#define degreesToRadians(x) (M_PI*(x)/180.0)

#if defined(SHAKE_UIVIEW_ANIMATION) && SHAKE_UIVIEW_ANIMATION
	static const void *isLeftKey = &isLeftKey;
	static const void *isEndKey = &isEndKey;
#else
	static const void *timerKey = &timerKey;
	static const void *imgKey = &imgKey;
#endif

@interface UIView ()

#if defined(SHAKE_UIVIEW_ANIMATION) && SHAKE_UIVIEW_ANIMATION
/**
 * Indicate the direction of the transform rotate.
 */
@property (nonatomic, assign) BOOL isLeft;

/**
 * Indicate the animation stoped.
 */
@property (nonatomic, assign) BOOL isEnd;
#else
/**
 * Timer for shake animation
 */
@property (nonatomic, retain) NSTimer *timer;

/**
 * Stored antialiased image, only antialias once.
 */
@property (nonatomic, retain) UIImage *img;
#endif

@end

@implementation UIView (Shake)

#if defined(SHAKE_UIVIEW_ANIMATION) && SHAKE_UIVIEW_ANIMATION
- (void)setIsLeft:(BOOL)isLeft
{
	objc_setAssociatedObject(self, isLeftKey, [NSNumber numberWithBool:isLeft], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isLeft
{
	return [objc_getAssociatedObject(self, isLeftKey) boolValue];
}

- (void)setIsEnd:(BOOL)isEnd
{
	objc_setAssociatedObject(self, isEndKey, [NSNumber numberWithBool:isEnd], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isEnd
{
	return [objc_getAssociatedObject(self, isEndKey) boolValue];
}

#else
- (void)setTimer:(NSTimer *)timer
{
	objc_setAssociatedObject(self, timerKey, timer, OBJC_ASSOCIATION_RETAIN);
}

- (NSTimer *)timer
{
	return objc_getAssociatedObject(self, timerKey);
}

- (void)setImg:(UIImage *)img
{
	objc_setAssociatedObject(self, imgKey, img, OBJC_ASSOCIATION_RETAIN);
}

- (UIImage *)img
{
	return objc_getAssociatedObject(self, imgKey);
}
#endif

- (void)beginShaking
{
	NSTimeInterval tI = 0.0f;
#if defined(SHAKE_UIVIEW_ANIMATION) && SHAKE_UIVIEW_ANIMATION
	if (!self.isEnd) return;
	self.isEnd = NO;
	self.isLeft = YES;
#endif
	
#if defined(RANDOM_SHAKE) && RANDOM_SHAKE
	int r = arc4random() % (int)(SHAKETIME * 100);
	tI = r / 100.0f;
#endif
	
#if defined(SHAKE_UIVIEW_ANIMATION) && SHAKE_UIVIEW_ANIMATION
	[self performSelector:@selector(shakeWithViewAnimation) withObject:nil afterDelay:tI];
#else
	[self performSelector:@selector(start) withObject:nil afterDelay:tI];
#endif
}

- (void)endShaking
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self];//fix bug:stop random animation
#if defined(SHAKE_UIVIEW_ANIMATION) && SHAKE_UIVIEW_ANIMATION
	self.isEnd = YES;
	self.transform = CGAffineTransformIdentity;
#else
	[self.timer invalidate], self.timer = nil;
	self.img = nil;
#endif
}

#if defined(SHAKE_UIVIEW_ANIMATION) && SHAKE_UIVIEW_ANIMATION
- (void)shakeWithViewAnimation
{
	if (!self.isEnd)
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:SHAKETIME / 2.0f];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(shakeWithViewAnimation)];
		CGAffineTransform tL = CGAffineTransformMakeRotation(degreesToRadians(-RADIUS));
		CGAffineTransform tR = CGAffineTransformMakeRotation(degreesToRadians(RADIUS));
		self.transform = self.isLeft ? tL : tR;
		self.isLeft = !self.isLeft;
		[UIView commitAnimations];
	}
}
#else
- (void)start
{
	if (self.timer)
	{
		[self.timer invalidate], self.timer = nil;
	}
	
	self.timer = [NSTimer scheduledTimerWithTimeInterval:SHAKETIME target:self selector:@selector(shake) userInfo:nil repeats:YES];
	[self.timer fire];

}

- (void)shake
{
	CAKeyframeAnimation *keyAn = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
	[keyAn setDuration:SHAKETIME];
	NSArray *array = @[@(degreesToRadians(0.f)), @(degreesToRadians(-RADIUS)), @(degreesToRadians(0.0f)), @(degreesToRadians(RADIUS)), @(degreesToRadians(0.0f))];
	[keyAn setValues:array];
	[array release], array = nil;
	
	if ([self isKindOfClass:[UIImageView class]] && self.img)
	{
		UIImageView *imgView = (UIImageView *)self;
		self.img = [self antialiasedImage:imgView.image size:imgView.frame.size];
		[imgView setImage:self.img];
	}
	[self.layer addAnimation:keyAn forKey:@"shake"];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage *)antialiasedImage:(UIImage *)img size:(CGSize)size
{
	UIGraphicsBeginImageContextWithOptions(size, NO, 1.0f);
	[img drawInRect:CGRectMake(1, 1, size.width-2, size.height-2)];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}
#endif

@end
