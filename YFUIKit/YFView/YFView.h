//
//  YFView.h
//
//	Copyright (c) 2013 Wanqiang Ji
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy of
//	this software and associated documentation files (the "Software"), to deal in
//	the Software without restriction, including without limitation the rights to use,
//	copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
//	Software, and to permit persons to whom the Software is furnished to do so,
//	subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//	FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//	COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//	IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <UIKit/UIKit.h>

/**
 * 战舰的基础员工仓室，扩展UIView
 */
typedef UIView YFView;

@interface UIView (Yef)

/**
 * YFView对象在父视图上显示的x值坐标
 */
@property (nonatomic, assign) CGFloat x;

/**
 * YFView对象在父视图上显示的y值坐标
 */
@property (nonatomic, assign) CGFloat y;

/**
 * YFView对象的宽
 */
@property (nonatomic, assign) CGFloat w;

/**
 * YFView对象的高
 */
@property (nonatomic, assign) CGFloat h;

/**
 * 从默认nib文件加载视图，默认nib所处bundle为主bundle并且名字与类名相同
 * @return UINib对象
 */
+ (UINib *)nib;

/**
 * 从指定nib文件加载视图
 * @param name nib文件名(NSString对象)
 * @param bundleOrNil NSBundle对象，若为nil则为主bundle对象
 * @return UINib对象
 */
+ (UINib *)nibWithNibName:(NSString *)name bundle:(NSBundle *)bundleOrNil;

/**
 * 默认从UINib对象进行实例化
 * @return instancetype
 */
+ (instancetype)instantiateFromNib;

/**
 * 设置YFView对象的位置
 * @param position CGPoint变量
 */
- (void)setPosition:(CGPoint)position;

/**
 * 设置YFView对象的大小
 * @param size CGSize变量
 */
- (void)setSize:(CGSize)size;

/**
 * 验证是否包含指定的view
 * @param view 子视图
 * @return 结果，YES拥有，NO不拥有
 */
- (BOOL)containsView:(YFView *)view;

@end
