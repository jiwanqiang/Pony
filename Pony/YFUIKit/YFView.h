//
//  YFView.h
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

#import <UIKit/UIKit.h>

/**
 *  UIView class
 */
typedef UIView YFView;

@interface UIView (Yef)

/**
 *  x axis value
 */
@property (nonatomic, assign) CGFloat x;

/**
 *  y axis value
 */
@property (nonatomic, assign) CGFloat y;

/**
 *  width
 */
@property (nonatomic, assign) CGFloat w;

/**
 *  height
 */
@property (nonatomic, assign) CGFloat h;

/**
 *  load nib file, the nib's default name is same to class name
 *
 *  @return UINib object
 */
+ (UINib *)nib;

/**
 *  load the appoint nib file
 *
 *  @param nibName     nib file's name
 *  @param bundleOrNil the bundle of the nib file locate
 *
 *  @return UINib object
 */
+ (UINib *)nibWithNibName:(NSString *)nibName bundle:(NSBundle *)bundleOrNil;

/**
 *  initalize from nib file
 *
 *  @return instacetype, UIView
 */
+ (instancetype)instantiateFromNib;

/**
 *  set view's position
 *
 *  @param position the view's position
 */
- (void)setPosition:(CGPoint)position;

/**
 *  set view's size
 *
 *  @param size the view's size
 */
- (void)setSize:(CGSize)size;

/**
 *  Judge self whether contains view
 *
 *  @param view view instance
 *
 *  @return YES, contains this view.
 */
//- (BOOL)containsView:(YFView *)view;

@end
