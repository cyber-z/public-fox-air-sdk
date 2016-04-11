//
//  DLAInterstitial.m
//  FoxANE
//
//  Created by 呉 維 on 2016/02/02.
//  Copyright © 2016年 cyberz0021. All rights reserved.
//

#import "DLAInterstitial.h"

const uint8_t* EVENT_LEVEL_INTERSTITIAL = (uint8_t*)"INTERSTITIAL";
const uint8_t* EVENT_CODE_INTERSTITIAL_SUCCESS = (uint8_t*)"SUCCESS";
const uint8_t* EVENT_CODE_INTERSTITIAL_FAILED = (uint8_t*)"FAILED";
const uint8_t* EVENT_CODE_INTERSTITIAL_CLOSED = (uint8_t*)"CLOSED";

@implementation DLAInterstitial

-(void)onAdSuccess:(UIView *)view {
    FREDispatchStatusEventAsync(self.ctx, EVENT_CODE_INTERSTITIAL_SUCCESS, EVENT_LEVEL_INTERSTITIAL);
}

-(void)onAdFailed:(UIView *)view {
    FREDispatchStatusEventAsync(self.ctx, EVENT_CODE_INTERSTITIAL_FAILED, EVENT_LEVEL_INTERSTITIAL);
}

-(void)onAdExit {
    FREDispatchStatusEventAsync(self.ctx, EVENT_CODE_INTERSTITIAL_CLOSED, EVENT_LEVEL_INTERSTITIAL);
}

@end
