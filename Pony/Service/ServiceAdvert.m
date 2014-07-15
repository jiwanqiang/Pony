//
//  ServiceAdvert.m
//
//  Copyright (c) 2013 Ji Wanqiang
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

#import "ServiceAdvert.h"
#import "UIApplication+Delay.h"

@implementation ServiceAdvert

- (id)init
{
	self = [super init];
	if (self)
	{
		
	}
	return self;
}

+ (void)saveAdvertWithURL:(NSURL *)url
{
	if (url)
	{
		//download the advert file
		[[AFImageRequestOperation imageRequestOperationWithRequest:[NSURLRequest requestWithURL:url]
														   success:^(UIImage *advert)
		  {
			  NSData *data = UIImagePNGRepresentation(advert);
			  [data writeToFile:[self advertPath] atomically:YES];
		  }] start];
	}
	else
	{
		//rm the advert file
		[self removeAdvertFile];
	}
}

+ (void)showInView:(UIView *)superView hideDelay:(NSTimeInterval)delay
{
	[[UIApplication sharedApplication] setStatusBarHidden:[self hasAdvertFile]];
	if ([self hasAdvertFile])
	{
		UIImageView *advertView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
		advertView.backgroundColor = [UIColor redColor];
		advertView.tag = 1111;
		NSString *filePath = [[self class] advertPath];
		UIImage *advertImg = [[UIImage alloc] initWithContentsOfFile:filePath];
		[advertView setImage:advertImg];
		[[UIApplication sharedApplication] setStatusBarHidden:YES];
		[superView addSubview:advertView];
		
		SEL action = @selector(removeFromSuperview);
		[[superView viewWithTag:1111] performSelector:action withObject:nil afterDelay:delay];
		
		action = @selector(setStatusBarHiddenWithObject:);
		[[UIApplication sharedApplication] performSelector:action withObject:@NO afterDelay:delay];
		[advertView release], advertView = nil;
	}

}

+ (NSString *)advertPath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	NSString *advertPath = [paths[0] stringByAppendingPathComponent:@"advertCache"];
	
	BOOL isDir;
	if (![[NSFileManager defaultManager] fileExistsAtPath:advertPath isDirectory:&isDir])
	{
		isDir = NO;
	}
	
	if (!isDir)
	{
		[fileManager createDirectoryAtPath:advertPath
			   withIntermediateDirectories:NO
								attributes:nil
									 error:nil];
	}
	
	return [advertPath stringByAppendingPathComponent:@"advert.png"];
}

+ (BOOL)hasAdvertFile
{
	return [[NSFileManager defaultManager] fileExistsAtPath:[self advertPath]];
}

+ (void)removeAdvertFile
{
	if ([self hasAdvertFile])
	{
		[[NSFileManager defaultManager] removeItemAtPath:[self advertPath] error:nil];
	}
}

@end
