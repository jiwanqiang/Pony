//
//  YefLogger.mm
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

#import "YFLogger.h"

@implementation YFLogger

- (id)init
{
	self = [super init];
	
	if (self)
	{
		//custom init method
	}
	
	return self;
}

+ (YFLogger *)sharedInstance
{
	static id __singleton;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^
	{
		__singleton = [[YFLogger alloc] init];
	});
	
	return __singleton;
}

- (void)consoleLogWithFormat:(NSString *)format, ...
{
	[self file:@(__FILE__) line:__LINE__ function:@(__PRETTY_FUNCTION__) format:format];
}

- (void)file:(NSString *)file line:(NSUInteger)line function:(NSString *)function format:(NSString *)format, ...
{
	@autoreleasepool
	{
		if (!format || ![format isKindOfClass:[NSString class]]) return;
		
		va_list args;
		va_start(args, format);
		
		NSArray *fileComponents = [file componentsSeparatedByString:@"/"];
		NSMutableString *text = [NSMutableString stringWithFormat:@"Yef>>>(%lu)%@>>>CONTENT::", (unsigned long)line, fileComponents.lastObject];
		NSString *content = [[NSString alloc] initWithFormat:(NSString *)format arguments:args];
		if (content && content.length)	[text appendString:content];
		
		fprintf(stderr, "%s\n", [text UTF8String], NULL);
		
		va_end(args);
	}
}

@end
