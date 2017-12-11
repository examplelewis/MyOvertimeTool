//
//  BFNonEmptyCollectionTesting.m
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/8.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import "BFNonEmptyCollectionTesting.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "Nimbus requires ARC support."
#endif

BOOL BFIsArrayWithObjects(id object) {
    return [object isKindOfClass:[NSArray class]] && [(NSArray*)object count] > 0;
}

BOOL BFIsSetWithObjects(id object) {
    return [object isKindOfClass:[NSSet class]] && [(NSSet*)object count] > 0;
}

BOOL BFIsStringWithAnyText(id object) {
    return [object isKindOfClass:[NSString class]] && [(NSString*)object length] > 0;
}
