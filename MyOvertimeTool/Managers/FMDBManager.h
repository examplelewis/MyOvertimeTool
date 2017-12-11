//
//  FMDBManager.h
//  MyOvertimeTool
//
//  Created by 龚宇 on 17/12/11.
//  Copyright © 2017年 gongyuTest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface FMDBManager : NSObject {
    FMDatabase *db;
}

+ (FMDBManager *)sharedManager;

@end