//
//  BFAppUtils.h
//  OkayappsFrameworkDev
//
//  Created by lcy on 14/12/12.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#if defined __cplusplus
extern "C" {
#endif
    
/**
 *  获取应用版本号
 *
 *  @return AppVersion
 */
NSString* BFGetAppVersion();

/**
 *  获取应用Build号
 *
 *  @return AppBuild
 */
NSString* BFGetAppBuild();
    
#if defined __cplusplus
};
#endif
