//
//  NSString+Regular.m
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

#import "NSString+Regular.h"

@implementation NSString (Regular)

- (BOOL)isMobileNumber
{
    NSString *regex = @"^(13[0-9]|15[0-35-9]|18[0-9]|14[57])[0-9]{8}$";
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex] evaluateWithObject:self];
}

- (BOOL)isEmailAddress
{
    NSString *regex = @"^([a-z0-9]+[_|-|.]?)*[a-z0-9]+@([a-z0-9]+[_|-|.]?)*[a-z0-9]+.[a-z]{2,3}$";
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex]
            evaluateWithObject:self.lowercaseString];
}

- (BOOL)containsEmojiSymbol:(NSString *__autoreleasing *)emojiSymbol
{
    __block BOOL ret = NO;
    __block NSString *symbol;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring,
                                       NSRange substringRange,
                                       NSRange enclosingRange,
                                       BOOL *stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              // surrogate pair
                              if (0xd800 <= hs && hs <= 0xdbff) {
                                  if (substring.length > 1) {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if (0x1d000 <= uc && uc <= 0x1f77f) {
                                          ret = YES;
                                      }
                                  }
                              } else if (substring.length > 1) {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3 || ls == 0xfe0f) {
                                      ret = YES;
                                  }
                              } else {
                                  // non surrogate
                                  if (0x2100 <= hs && hs <= 0x27ff) {
                                      ret = YES;
                                  } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                      ret = YES;
                                  } else if (0x2934 <= hs && hs <= 0x2935) {
                                      ret = YES;
                                  } else if (0x3297 <= hs && hs <= 0x3299) {
                                      ret = YES;
                                  } else if (   hs == 0xa9
                                             || hs == 0xae
                                             || hs == 0x303d
                                             || hs == 0x3030
                                             || hs == 0x2b55
                                             || hs == 0x2b1c
                                             || hs == 0x2b1b
                                             || hs == 0x2b50) {
                                      ret = YES;
                                  }
                              }
                              
                              if (ret) {
                                  *stop = YES;
                                  symbol = substring;
                              }
                          }];
    *emojiSymbol = symbol;
    return ret;
}

@end
