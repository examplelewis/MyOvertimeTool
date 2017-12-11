//
//  BFInterApp.h
//  OkayappsFrameworkDev
//
//  需要的框架：Foundation.framework、UIKit.framework、CoreLocation.framework
//
//  Created by xiongwei on 14/12/8.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "XworksCore.h"

@class BFMailAppInvocation;

@interface BFInterApp : NSObject

#pragma mark Chrome vs Safari

+ (void)setPreferGoogleChrome:(BOOL)preferGoogleChromeOverSafari;
+ (BOOL)preferGoogleChrome;
+ (BOOL)openPreferredBrowserWithURL:(NSURL *)url;

#pragma mark Safari

+ (BOOL)safariWithURL:(NSURL *)url;

#pragma mark Google Chrome

+ (BOOL)googleChromeIsInstalled;
+ (BOOL)googleChromeWithURL:(NSURL *)url;
+ (NSString *)googleChromeAppStoreId;

#pragma mark Google Maps

+ (BOOL)googleMapsIsInstalled;
+ (BOOL)googleMaps;
+ (NSString *)googleMapsAppStoreId;

+ (BOOL)googleMapAtLocation:(CLLocationCoordinate2D)location;
+ (BOOL)googleMapAtLocation:(CLLocationCoordinate2D)location title:(NSString *)title;
+ (BOOL)googleMapDirectionsFromLocation:(CLLocationCoordinate2D)fromLocation toLocation:(CLLocationCoordinate2D)toLocation;

// directionsMode can be nil. @"driving", @"transit", or @"walking".
+ (BOOL)googleMapDirectionsFromLocation:(CLLocationCoordinate2D)fromLocation toLocation:(CLLocationCoordinate2D)toLocation withMode:(NSString*)directionsMode;
+ (BOOL)googleMapDirectionsFromSourceAddress:(NSString *)srcAddr toDestAddress:(NSString *)destAddr withMode:(NSString *)directionsMode;

// these just use the user's current location (even if your application doesn't have locations services on, the google maps site/app MIGHT
+ (BOOL)googleMapDirectionsToDestAddress:(NSString *)destAddr withMode:(NSString *)directionsMode;
+ (BOOL)googleMapDirectionsToLocation:(CLLocationCoordinate2D)toLocation withMode:(NSString *)directionsMode;

+ (BOOL)googleMapWithQuery:(NSString *)query;

#pragma mark Phone

+ (BOOL)phone;
+ (BOOL)phoneWithNumber:(NSString *)phoneNumber;

#pragma mark SMS

+ (BOOL)sms;
+ (BOOL)smsWithNumber:(NSString *)phoneNumber;

#pragma mark Mail

+ (BOOL)mailWithInvocation:(BFMailAppInvocation *)invocation;

#pragma mark YouTube

+ (BOOL)youTubeWithVideoId:(NSString *)videoId;

#pragma mark App Store

+ (BOOL)appStoreWithAppId:(NSString *)appId;
+ (BOOL)appStoreGiftWithAppId:(NSString *)appId;
+ (BOOL)appStoreReviewWithAppId:(NSString *)appId;

#pragma mark iBooks

+ (BOOL)iBooksIsInstalled;
+ (BOOL)iBooks;
+ (NSString *)iBooksAppStoreId;

#pragma mark Facebook

+ (BOOL)facebookIsInstalled;
+ (BOOL)facebook;
+ (BOOL)facebookProfileWithId:(NSString *)profileId;
+ (NSString *)facebookAppStoreId;

#pragma mark Twitter

+ (BOOL)twitterIsInstalled;
+ (BOOL)twitter;
+ (BOOL)twitterWithMessage:(NSString *)message;
+ (BOOL)twitterProfileForUsername:(NSString *)username;
+ (NSString *)twitterAppStoreId;

#pragma mark Instagram

+ (BOOL)instagramIsInstalled;
+ (BOOL)instagram;
+ (BOOL)instagramCamera;
+ (BOOL)instagramProfileForUsername:(NSString *)username;
+ (NSURL *)urlForInstagramImageAtFilePath:(NSString *)filePath error:(NSError **)error;
+ (NSString *)instagramAppStoreId;

#pragma mark Custom Application

+ (BOOL)applicationIsInstalledWithScheme:(NSString *)applicationScheme;
+ (BOOL)applicationWithScheme:(NSString *)applicationScheme;
+ (BOOL)applicationWithScheme:(NSString *)applicationScheme andAppStoreId:(NSString *)appStoreId;
+ (BOOL)applicationWithScheme:(NSString *)applicationScheme andPath:(NSString *)path;
+ (BOOL)applicationWithScheme:(NSString *)applicationScheme appStoreId:(NSString *)appStoreId andPath:(NSString *)path;

@end

@interface BFMailAppInvocation : NSObject {
@private
    NSString* _recipient;
    NSString* _cc;
    NSString* _bcc;
    NSString* _subject;
    NSString* _body;
}

@property (nonatomic, copy) NSString* recipient;
@property (nonatomic, copy) NSString* cc;
@property (nonatomic, copy) NSString* bcc;
@property (nonatomic, copy) NSString* subject;
@property (nonatomic, copy) NSString* body;

/**
 * Returns an autoreleased invocation object.
 */
+ (id)invocation;

@end
