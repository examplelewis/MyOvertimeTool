//
//  BFDebuggingTools.h
//  OkayappsFrameworkDev
//
//  Debug相关函数以及宏定义，代码来自Nimbus
//
//  Created by xiongwei on 14/12/8.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//#if defined(DEBUG) || defined(BF_DEBUG)
//
///**
// * Assertions that only fire when DEBUG is defined.
// *
// * An assertion is like a programmatic breakpoint. Use it for sanity checks to save headache while
// * writing your code.
// */
//#import <TargetConditionals.h>
//
//#if defined __cplusplus
//extern "C" {
//#endif
//    
////int BFIsInDebugger(void);
//    
//void BFResetMaxLogLevel(void);
//    
//#if defined __cplusplus
//}
//#endif
//
//#if TARGET_IPHONE_SIMULATOR
//// We leave the __asm__ in this macro so that when a break occurs, we don't have to step out of
//// a "breakInDebugger" function.
//#define BFASSERT(xx) { if (!(xx)) { BFLog(@"BFASSERT failed: %s", #xx); \
//if (BFDebugAssertionsShouldBreak && BFIsInDebugger()) { __asm__("int $3\n" : : ); } } \
//} ((void)0)
//#else
//#define BFASSERT(xx) { if (!(xx)) { BFLog(@"BFASSERT failed: %s", #xx); \
//if (BFDebugAssertionsShouldBreak && BFIsInDebugger()) { raise(SIGTRAP); } } \
//} ((void)0)
//#endif // #if TARGET_IPHONE_SIMULATOR
//
//#else
//#define BFASSERT(xx) ((void)0)
//#endif // #if defined(DEBUG) || defined(BF_DEBUG)

#define BFASSERT(xx) ((void)0)


#define BFLOGLEVEL_INFO     5
#define BFLOGLEVEL_WARNING  3
#define BFLOGLEVEL_ERROR    1

/**
 * The maximum log level to output for Nimbus debug logs.
 *
 * This value may be changed at run-time.
 *
 * The default value is BFLOGLEVEL_WARNING.
 */
extern NSUInteger BFMaxLogLevel;

/**
 * Whether or not debug assertions should halt program execution like a breakpoint when they fail.
 *
 * An example of when this is used is in unit tests, when failure cases are tested that will
 * fire debug assertions.
 *
 * The default value is YES.
 */
extern BOOL BFDebugAssertionsShouldBreak;

/**
 * Only writes to the log when DEBUG is defined.
 *
 * This log method will always write to the log, regardless of log levels. It is used by all
 * of the other logging methods in Nimbus' debugging library.
 */
//#if defined(DEBUG) || defined(BF_DEBUG)
#define BFLog(xx, ...)  NSLog(@"%s(line:%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
//#else
//#define BFLog(xx, ...)  ((void)0)
//#endif // #if defined(DEBUG) || defined(BF_DEBUG)

/**
 * Write the containing method's name to the log using NIDPRINT.
 */
#define BFPRINTMETHODNAME() BFLog(@"%s", __PRETTY_FUNCTION__)

#if defined(DEBUG) || defined(BF_DEBUG)
/**
 * Only writes to the log if condition is satisified.
 *
 * This macro powers the level-based loggers. It can also be used for conditionally enabling
 * families of logs.
 */
#define BFCONDITIONLOG(condition, xx, ...) { if ((condition)) { BFLog(xx, ##__VA_ARGS__); } \
} ((void)0)
#else
#define BFCONDITIONLOG(condition, xx, ...) ((void)0)
#endif // #if defined(DEBUG) || defined(BF_DEBUG)


/**
 * Only writes to the log if BFMaxLogLevel >= BFLOGLEVEL_ERROR.
 */
#define BFERROR(xx, ...)  BFCONDITIONLOG((BFLOGLEVEL_ERROR <= BFMaxLogLevel), xx, ##__VA_ARGS__)

/**
 * Only writes to the log if BFMaxLogLevel >= BFLOGLEVEL_WARBFNG.
 */
#define BFWARNING(xx, ...)  BFCONDITIONLOG((BFLOGLEVEL_WARNING <= BFMaxLogLevel), \
xx, ##__VA_ARGS__)

/**
 * Only writes to the log if BFMaxLogLevel >= BFLOGLEVEL_INFO.
 */
#define BFINFO(xx, ...)  BFCONDITIONLOG((BFLOGLEVEL_INFO <= BFMaxLogLevel), xx, ##__VA_ARGS__)

/**@}*/// End of Debugging Tools //////////////////////////////////////////////////////////////////