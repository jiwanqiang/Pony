//
//  NSString+Regular.h
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

@interface NSString (Regular)

/**
 *  Match the mobile number which belonged to China.Return the match result.
 *
 *  @return Yes is mobile number
 */
- (BOOL)isMobileNumber;

/**
 *  Match the E-mail address,return the match result.But it should be update,
 *  because the top-level domain has been updated.
 *
 *  @return Yes is E-mail address
 */
- (BOOL)isEmailAddress;

/**
 *  Math the String wheter contains the emoji symbol
 *
 *  @param  emojiSymbol the emoji symbol that first matched
 *  @return Yes is means it contains emoji
 */
- (BOOL)containsEmojiSymbol:(NSString *__autoreleasing *)emojiSymbol;

@end
