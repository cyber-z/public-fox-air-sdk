//
//  DLAInterstitial.h
//  FoxANE
//
//  Created by 呉 維 on 2016/02/02.
//  Copyright © 2016年 cyberz0021. All rights reserved.
//

#import "DLInterstitialViewController.h"
#import "DLAdStateDelegate.h"
#import "FlashRuntimeExtensions.h"

@interface DLAInterstitial : NSObject<DLAdInterstitialStateDelegate>

@property FREContext ctx;

@end
