//
//  NSString+AES.m
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

#import "NSString+AES.h"
#import <CommonCrypto/CommonCryptor.h>

#if __has_feature(objc_arc)
    #error This file must be compiled with MRC. Use -fno-objc-arc flag (or convert project to ARC).
#endif

#if defined(CRYPT_RESULT_ENCODE_WAY) && CRYPT_RESULT_ENCODE_WAY
int convertHexChar(char hex_char)
{
	int int_ch = -1;
	
	if (hex_char >= '0' && hex_char <= '9')
	{
		int_ch = hex_char - '0';
	}
	else if (hex_char >= 'a' && hex_char <= 'z')
	{
		int_ch = hex_char - 'a' + 10;
	}
	else if (hex_char >= 'A' && hex_char <= 'Z')
	{
		int_ch = hex_char - 'A' + 10;
	}
	
	return int_ch;
}
#endif

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NSString (AES)

#if defined(CRYPT_RESULT_ENCODE_WAY) && CRYPT_RESULT_ENCODE_WAY
////////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSString *)__convertToHexString:(NSData *)data
{
	Byte *bytes = (Byte*)[data bytes];
	NSMutableString *hexString = [NSMutableString string];
	for(int i = 0; i < [data length]; i++)
	{
		[hexString appendFormat:@"%02x", bytes[i] & 0xff];
	}
	return hexString;
}

- (NSData *)__hexStringConvertToData
{
	NSUInteger hexLength = self.length;
	Byte bytes[hexLength/2];
	
	for (int i = 0; i < self.length/2; i++)
	{
		int int_ch1 = convertHexChar([self characterAtIndex:i*2]);
		int int_ch2 = convertHexChar([self characterAtIndex:i*2+1]);
		bytes[i] = int_ch1*16 + int_ch2;
	}
	
	return [NSData dataWithBytes:bytes length:sizeof(bytes)];
}
#endif
////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)__aesCryptWithkey:(NSString *)key iv:(NSString *)iv keySize:(NSInteger)keySize opeation:(CCOperation)op
{
	NSData *data = nil;
	if (op == kCCEncrypt)
	{
		data = [self dataUsingEncoding:NSUTF8StringEncoding];
	}
	else
	{
#if defined(CRYPT_RESULT_ENCODE_WAY) && CRYPT_RESULT_ENCODE_WAY
		data = [self __hexStringConvertToData];
#else
		data = [NSData dataWithBase64EncodedString:self];
#endif
	}
	
	//buffer
	NSUInteger dataLength = [data length];
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
	if (!buffer) return nil;
	
	//key
	char keyPtr[keySize+1];
	bzero(keyPtr, sizeof(keyPtr));
	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
	//iv
	const char *piv = [iv UTF8String];
	
	const void *dataIn = [data bytes];
	size_t dataOutMoved = 0;
	
	//operate
	CCCryptorStatus cryptStatus = CCCrypt(op,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          keySize,
                                          piv,
                                          dataIn,
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &dataOutMoved);
	
	if (cryptStatus == kCCSuccess)
	{
		//NSData takes ownership of the buffer and will free it on deallocation
		//so won't call free function
		if (op == kCCEncrypt)
		{
#if defined(CRYPT_RESULT_ENCODE_WAY) && CRYPT_RESULT_ENCODE_WAY
			return [[self class] __convertToHexString:[NSData dataWithBytesNoCopy:buffer
																		   length:dataOutMoved]];
#else
			return [[NSData dataWithBytesNoCopy:buffer length:dataOutMoved] base64Encoding];
#endif
		}
		else
		{
			return [[[NSString alloc] initWithData:[NSData dataWithBytesNoCopy:buffer
																		length:dataOutMoved]
										  encoding:NSUTF8StringEncoding] autorelease];
		}
	}
	free(buffer);
	return nil;
    
}

#pragma mark - Public Methods
- (NSString *)aes128EncryptWithKey:(NSString *)key iv:(NSString *)iv
{
	return [self __aesCryptWithkey:key iv:iv keySize:kCCKeySizeAES128 opeation:kCCEncrypt];
}

- (NSString *)aes192EncryptWithKey:(NSString *)key iv:(NSString *)iv
{
	return [self __aesCryptWithkey:key iv:iv keySize:kCCKeySizeAES192 opeation:kCCEncrypt];
}

- (NSString *)aes256EncryptWithKey:(NSString *)key iv:(NSString *)iv
{
	return [self __aesCryptWithkey:key iv:iv keySize:kCCKeySizeAES256 opeation:kCCEncrypt];
}

- (NSString *)aes128DencryptWithKey:(NSString *)key iv:(NSString *)iv
{
	return [self __aesCryptWithkey:key iv:iv keySize:kCCKeySizeAES128 opeation:kCCDecrypt];
}

- (NSString *)aes192DencryptWithKey:(NSString *)key iv:(NSString *)iv
{
	return [self __aesCryptWithkey:key iv:iv keySize:kCCKeySizeAES192 opeation:kCCDecrypt];
}

- (NSString *)aes256DencryptWithKey:(NSString *)key iv:(NSString *)iv
{
	return [self __aesCryptWithkey:key iv:iv keySize:kCCKeySizeAES256 opeation:kCCDecrypt];
}

@end
