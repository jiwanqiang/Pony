//
//  UIViewController+Rotate.m
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

#import "UIViewController+Rotate.h"
#import <objc/runtime.h>
#import <objc/message.h>


RotateTree rotateTreeDefault(void)
{
	RotateTree tree;
	tree.fromOrientation = UIDeviceOrientationPortrait;
	tree.toOrientation = UIDeviceOrientationUnknown;
	tree.statusBarOrientation = UIInterfaceOrientationPortrait;
	return tree;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation UIViewController (Rotate)

- (void)rotateFromPortraitToLandscapeRight:(BOOL)yes
{
	UIInterfaceOrientation statusBarOrientation = yes ? UIInterfaceOrientationLandscapeRight
	: UIInterfaceOrientationLandscapeLeft;
	self.view.frame = CGRectMake(0, 0, CGRectGetHeight(UIScreen.mainScreen.bounds), CGRectGetWidth(UIScreen.mainScreen.bounds)-20);
	[[UIApplication sharedApplication] setStatusBarOrientation:statusBarOrientation animated:YES];
	
	[UIView animateWithDuration:UIApplication.sharedApplication.statusBarOrientationAnimationDuration
					 animations:^(void)
	 {
		 CGFloat sbHeight = CGRectGetWidth(UIApplication.sharedApplication.statusBarFrame);
		 CGRect screenBounds = UIScreen.mainScreen.bounds;
		 CGFloat tx = (CGRectGetHeight(screenBounds) - CGRectGetWidth(screenBounds))/2 + sbHeight/2;
		 CGFloat ty = (CGRectGetHeight(screenBounds) - CGRectGetWidth(screenBounds))/2 - sbHeight/2;
		 tx = yes ? tx : tx-sbHeight;
		 CGAffineTransform transform = CGAffineTransformMakeTranslation(-tx,
																		ty);
		 
		 self.view.transform = CGAffineTransformRotate(transform, yes ? M_PI/2 : -M_PI/2);
	 }];
	
	if ([self respondsToSelector:@selector(hideTabBar:)])
	{
		objc_msgSend(self, @selector(hideTabBar:), YES);
	}
}

- (void)rotateFromLandscapeToPortrait
{
	[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
	
	[UIView animateWithDuration:UIApplication.sharedApplication.statusBarOrientationAnimationDuration
					 animations:^(void)
	 {
		 self.view.transform = CGAffineTransformIdentity;
	 }];
	
	self.view.frame = CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen.bounds), CGRectGetHeight(UIScreen.mainScreen.bounds) - 20);
	
	if ([self respondsToSelector:@selector(hideTabBar:)])
	{
		objc_msgSend(self, @selector(hideTabBar:), NO);
	}
}

- (void)rotateFromLandscapeToPortraitTest
{
	[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
	
	[UIView animateWithDuration:UIApplication.sharedApplication.statusBarOrientationAnimationDuration
					 animations:^(void)
	 {
		 self.view.transform = CGAffineTransformIdentity;
	 }];
	
	self.view.frame = CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen.applicationFrame), CGRectGetHeight(UIScreen.mainScreen.bounds));
	
	if ([self respondsToSelector:@selector(hideTabBar:)])
	{
		objc_msgSend(self, @selector(hideTabBar:), NO);
	}
}

- (void)rotateFromLandscapeLeftToRight:(BOOL)yes
{
	UIInterfaceOrientation statusBarOrientation = yes ? UIInterfaceOrientationLandscapeRight : UIInterfaceOrientationLandscapeLeft;
	[[UIApplication sharedApplication] setStatusBarOrientation:statusBarOrientation animated:YES];
	
	[UIView animateWithDuration:UIApplication.sharedApplication.statusBarOrientationAnimationDuration
					 animations:^(void)
	 {
		 CGFloat sbHeight = 20.0f;
		 CGRect screenBounds = UIScreen.mainScreen.bounds;
		 CGFloat tx = (CGRectGetHeight(screenBounds) - CGRectGetWidth(screenBounds))/2 + sbHeight/2;
		 CGFloat ty = (CGRectGetHeight(screenBounds) - CGRectGetWidth(screenBounds))/2 - sbHeight/2;
		 tx = yes ? tx : tx - sbHeight;
		 CGAffineTransform transform = yes ? CGAffineTransformMake(1, 0, 0, 1, -tx, ty)
		 : CGAffineTransformMake(1, 0, 0, 1, -tx, ty);
		 
		 self.view.transform = CGAffineTransformRotate(transform, yes ? M_PI/2 : -M_PI/2);;
	 }];
	
	if ([self respondsToSelector:@selector(hideTabBar:)])
	{
		objc_msgSend(self, @selector(hideTabBar:), YES);
	}
}

@end
