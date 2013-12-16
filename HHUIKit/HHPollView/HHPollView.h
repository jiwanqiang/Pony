//
//  HHPollView.h
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
 * HHPollView的数据源协议
 */
@protocol HHPollViewDataSource <NSObject>

/**
 * 页面数
 * @return NSUInteger 页面的个数 >= 0
 */
- (NSUInteger)numberOfPages;

/**
 * 加载当前索引页面的视图
 * @param index 要显示的索引值
 */
- (UIView *)pageAtIndex:(NSUInteger)index;

@end

@protocol HHPollViewDelegate;

/**
 * 焦点图轮播
 */
@interface HHPollView : UIView

/**
 * 轮询时间
 */
@property (nonatomic, assign) NSTimeInterval timerInterval;

@property (nonatomic, assign) id<HHPollViewDelegate> delegate;

@property (nonatomic, assign) id<HHPollViewDataSource> dataSource;

/**
 * 当前页面的索引值
 */
@property (nonatomic, readonly) NSInteger currentIndex;

/**
 * 刷新数据
 */
- (void)reloadData;

/**
 * 开启自动轮播
 * @return result YES代表成功
 */
- (BOOL)startAutoRun;

/**
 * 关闭自动轮播
 * @return result YES代表成功
 */
- (BOOL)stopAutoRun;

@end

/**
 * HHPollView的代理协议
 */
@protocol HHPollViewDelegate <NSObject>

@optional
/**
 * 当前的PollView被选择项的索引值，回调该函数
 * @param pollView HHPollView实例，内部回传
 * @param index	当前被选择项的索引值，内部回传
 */
- (void)pollView:(HHPollView *)pollView didSelectItemAtIndex:(NSUInteger)index;

/**
 * 当前页面的索引值改变时，回调该函数
 * @param pollView HHPollView实例，内部回传
 * @param index	改变后的索引值，内部回传
 */
- (void)pollView:(HHPollView *)pollView didChangeItemAtIndex:(NSUInteger)index;

@end
