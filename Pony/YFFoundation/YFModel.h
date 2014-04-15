//
//  YFModel.h
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

/**
 *  abstract class for Model
 */
@interface YFModel : NSObject <NSCoding, NSCopying>

/**
 *  parse the dictionary to YFModel's subclass object
 *
 *  @param object dictionary object
 *
 *  @return instancetype object
 */
+ (instancetype)modelParseWithObject:(NSDictionary *)object;

/**
 *  parse the dictionary to YFModel's subclass object
 *
 *  @param object dictionary object
 *  @param keys   the map between the local and the remote key
 *
 *  @return instancetype object
 */
+ (instancetype)modelParseWithObject:(NSDictionary *)object keys:(NSDictionary *)keys;

/**
 *  init object from the attributes's map
 *
 *  @param attributes dictionary object, map between the property and the property's value
 *
 *  @return instancetype object
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes;

/**
 *  reflect the attributes to dictionary object
 *
 *  @return dictionary object, the key is property, the value is the property's value
 */
- (NSDictionary *)dictionaryReflectFromAttributes;

/**
 *  create the map bwtween the local and the remote key
 *
 *  (subclass must be overwrite this method)
 *
 *  @return dictionary object, key is the local property, value is the remote property
 */
+ (NSDictionary *)generateKeys;

/**
 *  parse the JSON object to the property's value(TO-DO)
 *
 *  @param JSON JSON object
 *  @param keys the map between the local and the remote key
 */
- (void)parseWithJSON:(id)JSON keys:(NSDictionary *)keys;

/**
 *  auto generate the JSON string
 *
 *  @return string object which called JSON
 */
- (NSString *)JSONString;

/**
 *  auto generate the XML string(TO-DO)
 *
 *  @return string object which called XML
 */
- (NSString *)XMLString;

/**
 *  generate the map between the local and the remote key
 *
 *  default implement is called the + method which named generateKeys
 *
 *  @return dictionary object, key is the local property, value is the remote property
 */
- (NSDictionary *)generateKeys;

@end
