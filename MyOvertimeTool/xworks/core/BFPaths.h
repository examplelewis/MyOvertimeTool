//
//  BFPaths.h
//  OkayappsFrameworkDev
//
//  路径相关的函数，代码来自Nimbus
//
//  Created by xiongwei on 14/12/8.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#if defined __cplusplus
extern "C" {
#endif
    
/**
 * For creating standard system paths.
 *
 * @{
 */

/**
 * Create a path with the given bundle and the relative path appended.
 * 根据指定的bundle和给定的相对路径生成路径
 *
 * @param bundle 如果为nil，则使用[NSBundle mainBundle]
 * @param relativePath 要附加到bundle的相对路径
 * @returns
 */
NSString* BFPathForBundleResource(NSBundle* bundle, NSString* relativePath);

/**
 * 根据给定的相对路径，生成相对于应用文档目录的路径
 *
 * @returns
 */
NSString* BFPathForDocumentsResource(NSString* relativePath);

/**
 * 根据给定的相对路径，生成相对于Library目录的路径
 * @returns
 */
NSString* BFPathForLibraryResource(NSString* relativePath);

/**
 * 根据给定的相对路径，生成相对于缓存目录的路径
 * @returns
 */
NSString* BFPathForCachesResource(NSString* relativePath);
    
#if defined __cplusplus
};
#endif
