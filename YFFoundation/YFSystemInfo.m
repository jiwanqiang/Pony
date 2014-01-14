//
//  YefSystemInfo.m
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

#import "YFSystemInfo.h"
#include <math.h>

#import "OpenUDID.h"

@implementation YFSystemInfo

+ (YFSystemInfo *)sharedInstance
{
	static YFSystemInfo *__singletone;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^
	{
		__singletone = [[YFSystemInfo alloc] init];
	});
	return __singletone;
}

- (id)init
{
	self = [super init];
	
	if (self)
	{
		//custom init method
	}
	
	return self;
}

- (NSString *)ver
{
	return [UIDevice currentDevice].systemVersion;
}

- (NSString *)name
{
	return [UIDevice currentDevice].systemName;
}

- (NSString *)model
{
	return [[UIDevice currentDevice].model stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)resolution
{
	CGSize size = [UIScreen mainScreen].currentMode.size;
	if (size.height < size.width)
	{
		float tmp = size.height;
		size.height = size.width;
		size.width = tmp;
	}
	
	return [NSString stringWithFormat:@"%.f*%.f", size.height, size.width];
}

- (NSString *)openUDID
{
#if TARGET_IPHONE_SIMULATOR
	return @"SIMULATOR";
#else
	NSError *__autoreleasing error = nil;
	
	[OpenUDID valueWithError:&error];
	if (error)
	{
		INFO(@"UDID ERROR:%@", error);
		return @"ERROR";
	}
	return [OpenUDID value];
#endif
}

- (NSString *)appVersion
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	NSString *value = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
	if (!value || value.length == 0)
	{
		value = [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
	}
	return value;
#else
	return nil;
#endif
}

- (NSString *)bundleID
{
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
	NSString *value = [[NSBundle mainBundle] infoDictionary][@"CFBundleIdentifier"];
	if (!value || value.length == 0)
	{
		value = @"Faield";
	}
	return value;
#else
	return nil;
#endif
}

@end
