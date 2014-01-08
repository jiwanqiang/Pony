//
//  YefLogger.h
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

#import <Foundation/Foundation.h>

#if defined(__DEVELOP__) && __DEVELOP__
	#undef  INFO
	#define INFO( ... ) [[YFLogger sharedInstance] file:@(__FILE__) line:__LINE__ function:@(__PRETTY_FUNCTION__) format:__VA_ARGS__];

	#undef	NSLog
	#define NSLog( ... ) [[YFLogger sharedInstance] file:@(__FILE__) line:__LINE__ function:@(__PRETTY_FUNCTION__) format:__VA_ARGS__];
#endif

#undef  ERROR
#define ERROR( ... ) [[YFLogger sharedInstance] file:@(__FILE__) line:__LINE__ function:@(__PRETTY_FUNCTION__) format:__VA_ARGS__];

#undef  WARN
#define WARN( ... ) [[YFLogger sharedInstance] file:@(__FILE__) line:__LINE__ function:@(__PRETTY_FUNCTION__) format:__VA_ARGS__];

/**
 * YFLogger ouput the log into console or file.
 */
@interface YFLogger : NSObject

/**
 *  Singleton
 *
 *  @return YFLogger instance
 */
+ (YFLogger *)sharedInstance;

/**
 * output the information into console.
 *
 * @param file the file's path
 * @param line line number
 * @param function function name
 * @param format information which had be formated
 */
- (void)file:(NSString *)file line:(NSUInteger)line function:(NSString *)function format:(NSString *)format, ...;

@end
