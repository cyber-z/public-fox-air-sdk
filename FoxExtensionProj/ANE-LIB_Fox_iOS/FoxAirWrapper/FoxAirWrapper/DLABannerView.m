//
//  DLABanner.m
//  DLABanner
//
//  Created by Cyberz on 2016/02/02.
//  Copyright (c) 2016年 Cyberz. All rights reserved.
//

#import "DLABannerView.h"

const uint8_t* EVENT_LEVEL_BANNER = (uint8_t*)"BANNER";
const uint8_t* EVENT_CODE_BANNER_SUCCESS = (uint8_t*)"SUCCESS";
const uint8_t* EVENT_CODE_BANNER_FAILED = (uint8_t*)"FAILED";

@implementation DLABannerView

-(void)onAdSuccess:(UIView *)view {
    NSLog(@"onAdSuccess context %p", self.ctx);
    FREResult rs = FREDispatchStatusEventAsync(self.ctx, EVENT_CODE_BANNER_SUCCESS, EVENT_LEVEL_BANNER);
    NSLog(@"FREResult %d", rs);
    if (rs == FRE_OK) {
        NSLog(@"IOS dispatchEvent onAdSuccess OK");
    } else {
        NSLog(@"IOS dispatchEvent onAdSuccess NG");
    }
}

-(void)onAdFailed:(UIView *)view {
    FREResult rs = FREDispatchStatusEventAsync(self.ctx, EVENT_CODE_BANNER_FAILED, EVENT_LEVEL_BANNER);
    if (rs == FRE_OK) {
        NSLog(@"IOS dispatchEvent onAdFailed OK");
    } else {
        NSLog(@"IOS dispatchEvent onAdFailed NG");
    }
}

@end
