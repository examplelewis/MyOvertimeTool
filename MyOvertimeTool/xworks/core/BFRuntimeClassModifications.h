//
//  BFRuntimeClassModifications.h
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/10.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#if defined __cplusplus
extern "C" {
#endif

/**
 * 修改实例方法实现
 *
 * Use this method when you would like to replace an existing method implementation in a class
 * with your own implementation at runtime. In practice this is often used to replace the
 * implementations of UIKit classes where subclassing isn't an adequate solution.
 *
 * This will only work for methods declared with a -.
 *
 * After calling this method, any calls to originalSel will actually call newSel and vice versa.
 *
 * Uses method_exchangeImplementations to accomplish this.
 */
void BFSwapInstanceMethods(Class cls, SEL originalSel, SEL newSel);

/**
 * 实现静态方法实现
 *
 * Use this method when you would like to replace an existing method implementation in a class
 * with your own implementation at runtime. In practice this is often used to replace the
 * implementations of UIKit classes where subclassing isn't an adequate solution.
 *
 * This will only work for methods declared with a +.
 *
 * After calling this method, any calls to originalSel will actually call newSel and vice versa.
 *
 * Uses method_exchangeImplementations to accomplish this.
 */
void BFSwapClassMethods(Class cls, SEL originalSel, SEL newSel);
    
#if defined __cplusplus
};
#endif

/**@}*/// End of Runtime Class Modifications //////////////////////////////////////////////////////
