//
//  UIView+Base.m
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

#import "UIView+Base.h"

@implementation UIView (Base)

+ (UINib *)nib
{
	return [self nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}

+ (UINib *)nibWithNibName:(NSString *)name bundle:(NSBundle *)bundleOrNil
{
	return [UINib nibWithNibName:name bundle:bundleOrNil];
}

+ (instancetype)instantiateFromNib
{
	return [[self nib] instantiateWithOwner:nil options:nil].lastObject;
}

#pragma mark - Super Methods
- (void)awakeFromNib
{
	[super awakeFromNib];
}

#pragma mark - Setter and Getter
- (CGFloat)x
{
    return CGRectGetMinX(self.frame);
}

- (void)setX:(CGFloat)x
{
	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
}

- (CGFloat)y
{
    return CGRectGetMinY(self.frame);
}

- (void)setY:(CGFloat)y
{
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
}

- (CGFloat)w
{
    return CGRectGetWidth(self.frame);
}

- (void)setW:(CGFloat)w
{
	CGRect frame = self.frame;
	frame.size.width = w;
	self.frame = frame;
}

- (CGFloat)h
{
    return CGRectGetHeight(self.frame);
}

- (void)setH:(CGFloat)h
{
	CGRect frame = self.frame;
	frame.size.height = h;
	self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
	CGRect frame = self.frame;
	frame.size = size;
	self.frame = frame;
}

- (CGPoint)position
{
    return self.frame.origin;
}

- (void)setPosition:(CGPoint)position
{
	CGRect frame = self.frame;
	frame.origin = position;
	self.frame = frame;
}

#pragma mark - Public Methods
- (BOOL)containsView:(UIView *)view
{
	return [self.subviews containsObject:view];
}

@end
