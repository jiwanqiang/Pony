//
//  YFSandbox.h
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
 *  Sandbox of the app, it will return the path you need.
 */
@interface YFSandbox : NSObject

/**
 *  The app's install path.
 *
 *  @return absolute path
 */
+ (NSString *)appPath;

/**
 *  Perpetual path, it releated of iCloud.
 *
 *  @return absolute path
 */
+ (NSString *)docPath;

/**
 *  Library path, it contains the default path of cache and configuration.
 *
 *  @return absolute path
 */
+ (NSString *)libPath;

/**
 *  Caches path.
 *
 *  @return absolute path
 */
+ (NSString *)libCachePath;

/**
 *  The base path of the app's preference.
 *
 *  @return absolute path
 */
+ (NSString *)libPrefPath;

/**
 *  Download path, maybe it will be nil without this folder.
 *
 *  @return absolute path
 */
+ (NSString *)libDownloadPath;

/**
 *  The path of the app's temporary path.
 *
 *  @return absolute path
 */
+ (NSString *)tmpPath;

@end
