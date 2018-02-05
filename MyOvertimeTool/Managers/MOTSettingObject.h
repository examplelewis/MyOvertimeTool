//
//  MOTSettingObject.h
//  MyOvertimeTool
//
//  Created by 龚宇 on 18/02/05.
//  Copyright © 2018年 gongyuTest. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MOTSettingType) {
    MOTSettingUnknownType,
    MOTSettingOvertimeType,
    MOTSettingRestLeft,
};

@interface MOTSettingObject : NSObject

@property (nonatomic, assign) NSInteger idI;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, assign) MOTSettingType type;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
