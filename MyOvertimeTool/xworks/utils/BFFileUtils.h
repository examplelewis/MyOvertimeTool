//
//  BFFileUtils.h
//  OkayappsFrameworkDev
//
//  文件管理操作
//
//  Created by lcy on 14/12/11.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*!
 *  @class
 *  @author xiongwei
 *
 *  @brief  文件操作工具类
 */
@interface BFFileUtils : NSObject

#pragma mark - 获取文件属性

+(id)attributeOfItemAtPath:(NSString *)path forKey:(NSString *)key;
+(id)attributeOfItemAtPath:(NSString *)path forKey:(NSString *)key error:(NSError **)error;

+(NSDictionary *)attributesOfItemAtPath:(NSString *)path;
+(NSDictionary *)attributesOfItemAtPath:(NSString *)path error:(NSError **)error;

#pragma mark - 拷贝文件

+(BOOL)copyItemAtPath:(NSString *)path toPath:(NSString *)path;
+(BOOL)copyItemAtPath:(NSString *)path toPath:(NSString *)path error:(NSError **)error;

#pragma mark - 创建文件或者目录

+(BOOL)createDirectoriesForFileAtPath:(NSString *)path;
+(BOOL)createDirectoriesForFileAtPath:(NSString *)path error:(NSError **)error;

+(BOOL)createDirectoriesForPath:(NSString *)path;
+(BOOL)createDirectoriesForPath:(NSString *)path error:(NSError **)error;

+(BOOL)createFileAtPath:(NSString *)path;
+(BOOL)createFileAtPath:(NSString *)path error:(NSError **)error;

+(BOOL)createFileAtPath:(NSString *)path withContent:(NSObject *)content;
+(BOOL)createFileAtPath:(NSString *)path withContent:(NSObject *)content error:(NSError **)error;

#pragma mark - 获取创建时间

+(NSDate *)creationDateOfItemAtPath:(NSString *)path;
+(NSDate *)creationDateOfItemAtPath:(NSString *)path error:(NSError **)error;

#pragma mark - 清空文件夹

+(BOOL)emptyCachesDirectory;
+(BOOL)emptyTemporaryDirectory;

#pragma mark - 判断方法

+(BOOL)existsItemAtPath:(NSString *)path;

+(BOOL)isDirectoryItemAtPath:(NSString *)path;
+(BOOL)isDirectoryItemAtPath:(NSString *)path error:(NSError **)error;
+(BOOL)isEmptyItemAtPath:(NSString *)path;
+(BOOL)isEmptyItemAtPath:(NSString *)path error:(NSError **)error;
+(BOOL)isFileItemAtPath:(NSString *)path;
+(BOOL)isFileItemAtPath:(NSString *)path error:(NSError **)error;
+(BOOL)isExecutableItemAtPath:(NSString *)path;
+(BOOL)isReadableItemAtPath:(NSString *)path;
+(BOOL)isWritableItemAtPath:(NSString *)path;

#pragma mark - 列出目录文件

+(NSArray *)listFilesInDirectoryAtPath:(NSString *)path;
+(NSArray *)listFilesInDirectoryAtPath:(NSString *)path withExtension:(NSString *)extension;
+(NSArray *)listFilesInDirectoryAtPath:(NSString *)path withPrefix:(NSString *)prefix;
+(NSArray *)listFilesInDirectoryAtPath:(NSString *)path withSuffix:(NSString *)suffix;
+(NSArray *)listItemsInDirectoryAtPath:(NSString *)path deep:(BOOL)deep;

#pragma mark - 移动文件

+(BOOL)moveItemAtPath:(NSString *)path toPath:(NSString *)toPath;
+(BOOL)moveItemAtPath:(NSString *)path toPath:(NSString *)toPath error:(NSError **)error;

#pragma mark - 获取路径

+(NSString *)pathForApplicationSupportDirectory;
+(NSString *)pathForApplicationSupportDirectoryWithPath:(NSString *)path;

+(NSString *)pathForCachesDirectory;
+(NSString *)pathForCachesDirectoryWithPath:(NSString *)path;

+(NSString *)pathForDocumentsDirectory;
+(NSString *)pathForDocumentsDirectoryWithPath:(NSString *)path;

+(NSString *)pathForLibraryDirectory;
+(NSString *)pathForLibraryDirectoryWithPath:(NSString *)path;

+(NSString *)pathForMainBundleDirectory;
+(NSString *)pathForMainBundleDirectoryWithPath:(NSString *)path;

+(NSString *)pathForPlistNamed:(NSString *)name;

+(NSString *)pathForTemporaryDirectory;
+(NSString *)pathForTemporaryDirectoryWithPath:(NSString *)path;

#pragma mark - 读取文件

+(NSString *)readFileAtPath:(NSString *)path;
+(NSString *)readFileAtPath:(NSString *)path error:(NSError **)error;

+(NSArray *)readFileAtPathAsArray:(NSString *)path;

+(NSObject *)readFileAtPathAsCustomModel:(NSString *)path;

+(NSData *)readFileAtPathAsData:(NSString *)path;
+(NSData *)readFileAtPathAsData:(NSString *)path error:(NSError **)error;

+(NSDictionary *)readFileAtPathAsDictionary:(NSString *)path;

+(UIImage *)readFileAtPathAsImage:(NSString *)path;
+(UIImage *)readFileAtPathAsImage:(NSString *)path error:(NSError **)error;

+(UIImageView *)readFileAtPathAsImageView:(NSString *)path;
+(UIImageView *)readFileAtPathAsImageView:(NSString *)path error:(NSError **)error;

+(NSDictionary *)readFileAtPathAsJSON:(NSString *)path;
+(NSDictionary *)readFileAtPathAsJSON:(NSString *)path error:(NSError **)error;

+(NSMutableArray *)readFileAtPathAsMutableArray:(NSString *)path;

+(NSMutableData *)readFileAtPathAsMutableData:(NSString *)path;
+(NSMutableData *)readFileAtPathAsMutableData:(NSString *)path error:(NSError **)error;

+(NSMutableDictionary *)readFileAtPathAsMutableDictionary:(NSString *)path;

+(NSString *)readFileAtPathAsString:(NSString *)path;
+(NSString *)readFileAtPathAsString:(NSString *)path error:(NSError **)error;

#pragma mark - 删除文件

+(BOOL)removeFilesInDirectoryAtPath:(NSString *)path;
+(BOOL)removeFilesInDirectoryAtPath:(NSString *)path error:(NSError **)error;
+(BOOL)removeFilesInDirectoryAtPath:(NSString *)path withExtension:(NSString *)extension;
+(BOOL)removeFilesInDirectoryAtPath:(NSString *)path withExtension:(NSString *)extension error:(NSError **)error;
+(BOOL)removeFilesInDirectoryAtPath:(NSString *)path withPrefix:(NSString *)prefix;
+(BOOL)removeFilesInDirectoryAtPath:(NSString *)path withPrefix:(NSString *)prefix error:(NSError **)error;
+(BOOL)removeFilesInDirectoryAtPath:(NSString *)path withSuffix:(NSString *)suffix;
+(BOOL)removeFilesInDirectoryAtPath:(NSString *)path withSuffix:(NSString *)suffix error:(NSError **)error;

+(BOOL)removeItemsInDirectoryAtPath:(NSString *)path;
+(BOOL)removeItemsInDirectoryAtPath:(NSString *)path error:(NSError **)error;

+(BOOL)removeItemAtPath:(NSString *)path;
+(BOOL)removeItemAtPath:(NSString *)path error:(NSError **)error;

+(BOOL)renameItemAtPath:(NSString *)path withName:(NSString *)name;
+(BOOL)renameItemAtPath:(NSString *)path withName:(NSString *)name error:(NSError **)error;

#pragma mark - 文件数量

+(NSNumber *)sizeOfItemAtPath:(NSString *)path;
+(NSNumber *)sizeOfItemAtPath:(NSString *)path error:(NSError **)error;

#pragma mark - 文件URL

+(NSURL *)urlForItemAtPath:(NSString *)path;

#pragma mark - 写入文件

+(BOOL)writeFileAtPath:(NSString *)path content:(NSObject *)content;
+(BOOL)writeFileAtPath:(NSString *)path content:(NSObject *)content error:(NSError **)error;

@end

    
