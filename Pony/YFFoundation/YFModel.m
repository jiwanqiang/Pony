//
//  YFModel.m
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

#if !__has_feature(objc_arc)
	#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import "YFModel.h"
#import <objc/message.h>

@implementation YFModel

#pragma mark - Initialize
- (id)init
{
    self = [super init];
    
    if (self) {
		//custom init method
    }
    
    return self;
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    
    if (self) {
        for (NSString *key in attributes.allKeys) {
            [self setValue:attributes[key] forKey:key];
        }
    }
    
    return self;
}

+ (instancetype)modelParseWithObject:(NSDictionary *)object
{
    return [self modelParseWithObject:object keys:[self generateKeys]];
}

+ (instancetype)modelParseWithObject:(NSDictionary *)object keys:(NSDictionary *)keys
{
    @autoreleasepool {
        if (!object || ![object isKindOfClass:[NSDictionary class]]) {
#ifdef ERROR
            ERROR(@"The param of object must not be nil and the class type must be NSDictionary.");
#endif
            return nil;
        }
		
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        
        for (NSString *key in keys.allKeys) {
            attributes[key] = object[keys[key]] ? object[keys[key]] : @"";
        }
        
        YFModel *model = [[self alloc] initWithAttributes:attributes];
        return model;
    }
}

+ (NSDictionary *)generateKeys
{
    return nil;
}

#pragma mark - Super Methods
#pragma mark -
- (NSString *)description
{
    @autoreleasepool {
        NSMutableString *desc = [NSMutableString stringWithFormat:@"<%@ %p>\n{\n",
                                 NSStringFromClass([self class]), self];
        
        NSDictionary *attributes = [self dictionaryReflectFromAttributes];
        
        for (NSString *key in attributes) {
            [desc appendFormat:@"\t%@ = %@,\n", key, attributes[key] ? attributes[key] : @"<null>"];
        }
		
        [desc appendString:@"}"];
        return desc;
    }
}

#pragma mark - NSCoding Methods
#pragma mark -
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        unsigned int count = 0;
        objc_property_t *attributes = class_copyPropertyList([self class], &count);
        objc_property_t property;
        NSString *key;
		
        for (int i = 0; i < count; i++) {
            property = attributes[i];
            key = [NSString stringWithUTF8String:property_getName(property)];
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
        
        free(attributes);
        attributes = nil;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    objc_property_t *attributes = class_copyPropertyList([self class], &count);
    objc_property_t property;
    NSString *key;
    id value;
    
    for (int i = 0; i < count; i++) {
        property = attributes[i];
        key = [NSString stringWithUTF8String:property_getName(property)];
        value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    
    free(attributes);
    attributes = nil;
}

#pragma mark - NSCopying Methods
#pragma mark -
- (id)copyWithZone:(NSZone *)zone
{
    // To-Do
    return nil;
}

#pragma mark - Public Methods
#pragma mark -
- (NSDictionary *)dictionaryReflectFromAttributes
{
    @autoreleasepool {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        unsigned int count = 0;
        objc_property_t *attributes = class_copyPropertyList([self class], &count);
        objc_property_t property;
        NSString *key;
        id value;
        
        for (int i = 0; i < count; i++) {
            property = attributes[i];
            key = [NSString stringWithUTF8String:property_getName(property)];
            value = [self valueForKey:key];
            [dict setObject:(value ? value : @"") forKey:key];
        }
		
        free(attributes);
        attributes = nil;
        
        return dict;
    }
}

- (void)parseWithJSON:(id)JSON keys:(NSDictionary *)keys
{
    //TO-DO
}

- (NSString *)JSONString
{
    NSDictionary *dict = [self dictionaryReflectFromAttributes];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (jsonData.length > 0 && !error) {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    
    return nil;
}

- (NSString *)XMLString
{
    //TO-DO
    return nil;
}

- (NSDictionary *)generateKeys
{
    return [[self class] generateKeys];
}

@end
