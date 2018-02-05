//
//  MOTSettingObject.m
//  MyOvertimeTool
//
//  Created by 龚宇 on 18/02/05.
//  Copyright © 2018年 gongyuTest. All rights reserved.
//

#import "MOTSettingObject.h"

@implementation MOTSettingObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _idI = [dictionary[@"id"] integerValue];
        _title = dictionary[@"title"];
        _value = dictionary[@"value"];
        _key = dictionary[@"key"];
        _desc = dictionary[@"desc"];
        
        if ([_key isEqualToString:@"overtimeType"]) {
            _type = MOTSettingOvertimeType;
        } else if ([_key isEqualToString:@"restLeft"]) {
            _type = MOTSettingRestLeft;
        } else {
            _type = MOTSettingUnknownType;
        }
    }
    
    return self;
}

@end
