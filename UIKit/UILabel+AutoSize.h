//
//  UILabel+AutoSize.h
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

#import <UIKit/UIKit.h>

@interface UILabel (AutoSize)

/**
 *  Auto fit the configure, ouput the suitable size.
 *
 *  Had adapted to the iOS7, we used the new method boundingRectWithSize:options:attributes:context: beyond the iOS7.
 *
 *  @return new size
 */
- (CGSize)sizeToFitConfigure;

/**
 *  Auto fit the configure which limited the number of lines, output the suitable size.
 *
 *  @see sizeToFitMaxBoundsLimitedToNumberOfLines:
 *
 *  @return new size
 */
- (CGSize)sizeToFitLimitedConfigure;

/**
 *  Auto fit the max bounds, output the suitable size.
 *
 *  The max bounds is the UILabel's max bounds you want to show for user.
 *
 *  @see sizeToFitLimitedConfigure
 *
 *  @param numberOfLines number of lines
 *
 *  @return new size
 */
- (CGSize)sizeToFitMaxBoundsLimitedToNumberOfLines:(NSInteger)numberOfLines;

@end
