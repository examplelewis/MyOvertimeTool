//
//  BFRuntimeClassModifications.m
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/10.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import "BFRuntimeClassModifications.h"

#import <objc/runtime.h>

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "OkayappsFramework requires ARC support."
#endif

void BFSwapInstanceMethods(Class cls, SEL originalSel, SEL newSel) {
    Method originalMethod = class_getInstanceMethod(cls, originalSel);
    Method newMethod = class_getInstanceMethod(cls, newSel);
    method_exchangeImplementations(originalMethod, newMethod);
}

void BFSwapClassMethods(Class cls, SEL originalSel, SEL newSel) {
    Method originalMethod = class_getClassMethod(cls, originalSel);
    Method newMethod = class_getClassMethod(cls, newSel);
    method_exchangeImplementations(originalMethod, newMethod);
}
