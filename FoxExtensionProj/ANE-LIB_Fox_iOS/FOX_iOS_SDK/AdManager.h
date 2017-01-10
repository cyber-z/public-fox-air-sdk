//
//  AdManager.h
//  Force Operation X
//
//  Copyright 2014 CyberZ, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppAdForceManager : NSObject

#pragma mark - main API
-(void) sendConversionWithStartPage:(NSString*) url;
-(void) sendConversionWithStartPage:(NSString*) url buid:(NSString*) buid;
-(void) setUrlScheme:(NSURL*) url;
-(void) setUrlSchemeWithOptions:(NSDictionary *) launchOptions;

#pragma mark - optional API
-(void) setOptout:(BOOL) optout;
-(void) setDebugMode:(BOOL) debug;
-(void) cacheDefaultUserAgent;
-(void) setStartPageVisible:(BOOL) visible;
-(void) setDefaultDeferredDeeplinkHandler;
-(void) setDeferredDeeplinkValidDuration:(NSTimeInterval) durationSinceClick andHandler:(void (^)(NSString* url))handler;

#pragma mark - utility
+(AppAdForceManager*) sharedManager;

@end
