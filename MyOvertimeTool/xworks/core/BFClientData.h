/**
 * Cobub Razor
 *
 * An open source analytics iphone sdk for mobile applications
 *
 * @package		Cobub Razor
 * @author		WBTECH Dev Team
 * @copyright	Copyright (c) 2011 - 2012, NanJing Western Bridge Co.,Ltd.
 * @license		http://www.cobub.com/products/cobub-razor/license
 * @link		http://www.cobub.com/products/cobub-razor/
 * @since		Version 0.1
 * @filesource
 */
#import <Foundation/Foundation.h>

@interface BFClientData : NSObject<NSCoding>
{
    NSString *platform;
    NSString *os_version;
    NSString *language;
    NSString *resolution;
    NSString *deviceid;
    NSString *mccmnc;
    NSString *version;
    NSString *network;
    NSString *devicename;
    NSString *modulename;
    NSString *time;
    NSString *isjailbroken;
}

@property (nonatomic,copy) NSString *platform;
@property (nonatomic,copy) NSString *os_version;
@property (nonatomic,copy) NSString *language;
@property (nonatomic,copy) NSString *resolution;
@property (nonatomic,copy) NSString *deviceid;
@property (nonatomic,copy) NSString *mccmnc;
@property (nonatomic,copy) NSString *version;
@property (nonatomic,copy) NSString *network;
@property (nonatomic,copy) NSString *devicename;
@property (nonatomic,copy) NSString *modulename;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *isjailbroken;

@end
