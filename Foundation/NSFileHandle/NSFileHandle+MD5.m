//
//  NSFileHandle+MD5.m
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


#import "NSFileHandle+MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSFileHandle (MD5)

- (NSString *)MD5
{
	CC_MD5_CTX md5_ctx;
	CC_MD5_Init(&md5_ctx);
	
	NSData *fileData;
	do {
		@autoreleasepool {
			fileData = [self readDataOfLength:1024];
			CC_MD5_Update(&md5_ctx, [fileData bytes], (CC_LONG)[fileData length]);
		}
	} while ([fileData length]);
	
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5_Final(result, &md5_ctx);

	NSMutableString *hashString = [NSMutableString string];
	for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		[hashString appendFormat:@"%02x",result[i]];
	}
    
	return [hashString lowercaseString];
}

@end
