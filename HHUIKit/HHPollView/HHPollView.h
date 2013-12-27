//
//  HHPollView.h
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
 *  HHPollView DataSource Protocol
 */
@protocol HHPollViewDataSource <NSObject>

/**
 *  Tells the data source to return the number of page of a poll view. (required)
 *
 *  @return the number of pages
 */
- (NSUInteger)numberOfPages;

/**
 *  Asks the data source for a page to insert in a particular location of the poll view. (required)
 *
 *  @param index display index
 *
 *  @return UIView instance
 */
- (UIView *)pageAtIndex:(NSUInteger)index;

@end

@protocol HHPollViewDelegate;

/**
 * HHPollView which implements the infinite loop style
 */
@interface HHPollView : UIView <UITableViewDataSource>

/**
 *  The interval of the loop.
 */
@property (nonatomic, assign) NSTimeInterval timerInterval;

/**
 *  The object that acts as the delegate of the receiving poll view.
 */
@property (nonatomic, assign) id<HHPollViewDelegate> delegate;

/**
 *  The object that acts as the data source of the receiving poll view.
 */
@property (nonatomic, assign) id<HHPollViewDataSource> dataSource;

/**
 *  The index of the selected page in the receiving poll view.
 */
@property (nonatomic, readonly) NSInteger currentIndex;

/**
 *  Reloads the page of the receiver.
 */
- (void)reloadData;

/**
 *  Start auto running.
 *
 *  @return YES, success
 */
- (BOOL)startAutoRun;

/**
 *  Stop auto running.
 *
 *  @return YES, success
 */
- (BOOL)stopAutoRun;

@end

/**
 *  HHPollView Delegate Protocol
 */
@protocol HHPollViewDelegate <NSObject>

@optional

/**
 *  Tells the delegate that the specified row is now selected.
 *
 *  @param pollView current pollview
 *  @param index    current index which be selected
 */
- (void)pollView:(HHPollView *)pollView didSelectItemAtIndex:(NSUInteger)index;

/**
 *  Tells the delgate that the currentIndex is changed.
 *
 *  @param pollView pollview instance
 *  @param index    changed index
 */
- (void)pollView:(HHPollView *)pollView didChangeItemAtIndex:(NSUInteger)index;

@end
