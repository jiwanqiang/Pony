//
//  UILabel+AutoSize.m
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

#import "UILabel+AutoSize.h"

@implementation UILabel (AutoSize)

- (CGSize)sizeToFitConfigure
{
#if (__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0)
    BOOL result = floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1;
    return result ? [self __calSizeAbove7] : [self __calSizeBelow7];
#else
    return [self __calSizeAbove7];
#endif
}

- (CGSize)sizeToFitLimitedConfigure
{
    return [self sizeToFitMaxBoundsLimitedToNumberOfLines:self.numberOfLines];
}

- (CGSize)sizeToFitMaxBoundsLimitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect bounds = CGRectMake(0.f, 0.f, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    CGRect rect = [self textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    return rect.size;
}

#pragma mark - Private Methods

#if (__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0)
- (CGSize)__calSizeBelow7
{
    CGSize cSize = CGSizeMake(CGRectGetWidth(self.bounds), MAXFLOAT);
    CGSize size = [self.text sizeWithFont:self.font
                        constrainedToSize:cSize
                            lineBreakMode:self.lineBreakMode];
    
    return size;
}
#endif

- (CGSize)__calSizeAbove7
{
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
    NSDictionary *attr = @{NSFontAttributeName: self.font};
    CGSize bSize = CGSizeMake(CGRectGetWidth(self.bounds), MAXFLOAT);
    CGRect rect = [self.text boundingRectWithSize:bSize
                                          options:options
                                       attributes:attr
                                          context:nil];
    return rect.size;
}

@end
