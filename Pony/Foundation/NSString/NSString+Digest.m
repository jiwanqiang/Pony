//
//  NSString+Digest.m
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

#import "NSString+Digest.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Digest)

- (NSString *)MD5
{
	const char *cStr = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
	
	NSMutableString *hashString = [NSMutableString string];
	for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
	{
		[hashString appendFormat:@"%02x", result[i]];
	}
	
	return [hashString lowercaseString];
}

- (NSString *)SHA1
{
	const char *cStr = [self UTF8String];
	unsigned char result[CC_SHA1_DIGEST_LENGTH];
	CC_SHA1(cStr, (CC_LONG)strlen(cStr), result);
	
	NSMutableString *hashString = [NSMutableString string];
	for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
	{
		[hashString appendFormat:@"%02x", result[i]];
	}
	
	return [hashString lowercaseString];
}

@end
