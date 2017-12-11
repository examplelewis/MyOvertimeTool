//
//  BFPaths.m
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/8.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import "BFPaths.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "OkayappsFramework requires ARC support."
#endif

///////////////////////////////////////////////////////////////////////////////////////////////////
NSString* BFPathForBundleResource(NSBundle* bundle, NSString* relativePath) {
    NSString* resourcePath = [(nil == bundle ? [NSBundle mainBundle] : bundle) resourcePath];
    return [resourcePath stringByAppendingPathComponent:relativePath];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
NSString* BFPathForDocumentsResource(NSString* relativePath) {
    static NSString* documentsPath = nil;
    if (nil == documentsPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                            NSUserDomainMask,
                                                            YES);
        documentsPath = [dirs objectAtIndex:0];
    }
    return [documentsPath stringByAppendingPathComponent:relativePath];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
NSString* BFPathForLibraryResource(NSString* relativePath) {
    static NSString* libraryPath = nil;
    if (nil == libraryPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                            NSUserDomainMask,
                                                            YES);
        libraryPath = [dirs objectAtIndex:0];
    }
    return [libraryPath stringByAppendingPathComponent:relativePath];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
NSString* BFPathForCachesResource(NSString* relativePath) {
    static NSString* cachesPath = nil;
    if (nil == cachesPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                            NSUserDomainMask,
                                                            YES);
        cachesPath = [dirs objectAtIndex:0];
    }
    return [cachesPath stringByAppendingPathComponent:relativePath];
}
