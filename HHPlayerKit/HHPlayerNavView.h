//
//  HHPlayerNavView.h
//
//  Copyright (c) 2013 Wanqiang Ji
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//

#import <UIKit/UIKit.h>

#define HH_BUTTON_BACK_L 14.f
#define HH_BUTTON_BACK_T 10.f
#define HH_BUTTON_BACK_W 63.f
#define HH_BUTTON_BACK_H 37.f

#define HH_LABEL_NAV_TITLE_FONT [UIFont boldSystemFontOfSize:20.f]
#define HH_LABEL_NAV_TITLE_COLOR [UIColor whiteColor]

/**
 *  The navigation view of the Player.
 */
@interface HHPlayerNavView : UIView
{
  @private
    UIImageView *_bgImgView;
    UILabel *_titleLabel;
}

/**
 *  Returns a button which location at the left.
 */
@property (nonatomic, readonly) UIButton *backButton;

/**
 *  The title will display in center.
 */
@property (nonatomic, copy) NSString *title;

/**
 *  Set the background image.
 *
 *  @param img background image
 */
- (void)setBackgroundImage:(UIImage *)img;

/**
 *  Set the back button's image
 *
 *  @param nImg normal image
 *  @param hImg highlighted image
 */
- (void)setBackButtonNormalImage:(UIImage *)nImg highlightedImage:(UIImage *)hImg;

@end
