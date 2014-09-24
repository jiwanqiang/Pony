//
//  NSString+AES.h
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

#import <Foundation/Foundation.h>

#define CRYPT_RESULT_ENCODE_WAY (0) //1 hex 0 base64

#if defined(CRYPT_RESULT_ENCODE_WAY) && CRYPT_RESULT_ENCODE_WAY

#else
    #import "NSData+Base64.h"
#endif

/**
 * ECB、CBC、CFB、OFB
 * if the crypt type isn't the ECB, then you shoud input the iv which meaned the key's offset.
 */
@interface NSString (AES)

/**
 *  Encrypt and Dencrypt
 *
 *  @param key secret key
 *  @param iv  offset
 *
 *  @return string
 */
- (NSString *)aes128EncryptWithKey:(NSString *)key iv:(NSString *)iv;
- (NSString *)aes192EncryptWithKey:(NSString *)key iv:(NSString *)iv;
- (NSString *)aes256EncryptWithKey:(NSString *)key iv:(NSString *)iv;

- (NSString *)aes128DencryptWithKey:(NSString *)key iv:(NSString *)iv;
- (NSString *)aes192DencryptWithKey:(NSString *)key iv:(NSString *)iv;
- (NSString *)aes256DencryptWithKey:(NSString *)key iv:(NSString *)iv;

@end
