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
 * 基础模型抽象类，不能直接使用。
 */
@interface YFModel : NSObject

/**
 * 从对象文件根据keys进行解析为Model
 *
 * @param object 对象文件
 * @param keys key值集合，譬如：key值为属性
 *
 * @return YFModel对象
 */
+ (instancetype)modelParseWithObject:(NSDictionary *)object keys:(NSDictionary *)keys;

/**
 * 通过字典文件进行视频节点的初始化，其中字典文件中的key值为属性名
 *
 * @param attributes 包含所有属性的字典文件，key值为属性
 *
 * @return Modle对象
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes;

/**
 * 从属性反射一个字典文件
 *
 * @return NSDictionary key值为属性，value为属性值
 */
- (NSDictionary *)dictionaryReflectFromAttributes;

/**
 *  从JSON数据解析为对象文件
 *
 *  @param JSON JSON数据
 *  @param keys 属性的key对JSON的key，即key = JSONkey
 */
- (void)parseWithJSON:(id)JSON keys:(NSDictionary *)keys;

/**
 *  自动生成JSON对象 TO-DO
 *
 *  @return JSON字符串
 */
- (NSString *)JSONString;

/**
 *  自动生成XML串 TO-DO
 *
 *  @return XML字符串
 */
- (NSString *)XMLString;

/**
 *  创建本地与服务器之间的映射(重写)
 *
 *  @return 字典文件对象 key为本地 value为服务端
 */
- (NSDictionary *)generateKeys;

@end
