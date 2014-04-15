//
//  UIView+Base.h
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

/**
 *  The base category of UIView
 */
@interface UIView (Base)

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
 *  size of the view
 */
@property (nonatomic, assign) CGSize size;

/**
 *  position of the super view
 */
@property (nonatomic, assign) CGPoint position;

/**
 *  load nib file, the nib's default name is same to class name
 *
 *  @return UINib object
 */
+ (UINib *)nib;

/**
 *  Returns an UINib object initialized to the nib file in the specified bundle.
 *
 *  The UINib object looks for the nib file in the bundle's language-specific project directories first, followed by the Resources directory.
 *
 *  @param nibName     The name of the nib file, without any leading path information.
 *  @param bundleOrNil The bundle in which to search for the nib file. If you specify nil, this method looks for the nib file in the main bundle.
 *
 *  @return The initialized UINib object or nil if there were errors during initialization or the nib file could not be located.
 */
+ (UINib *)nibWithNibName:(NSString *)nibName bundle:(NSBundle *)bundleOrNil;

/**
 *  initalize from nib file
 *
 *  @return instacetype, UIView
 */
+ (instancetype)instantiateFromNib;

/**
 *  Judge self whether contains view
 *
 *  @param view view instance
 *
 *  @return YES, contains this view.
 */
- (BOOL)containsView:(UIView *)view;

@end
