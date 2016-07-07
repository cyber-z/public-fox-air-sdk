//
//  DLInterstitialViewController.h
//  DahliaSdkCore
//
//  Created by 呉 維 on 2015/12/04.
//  Copyright © 2015年 CyberZ. All rights reserved.
//
//  Edited by MMizogaki on 6/2/16.
//  Copyright © 2016 CyberZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLAdStateDelegate.h"

/*!
 @Class    DLInterstitialViewController
 @abstract InterstitialAd広告を表示するViewControllerの管理
 */

@interface DLInterstitialViewController : UIViewController

@property NSString* _Nonnull placementId;

@property (weak) id<DLAdInterstitialStateDelegate> _Nullable adStateDelegate;


#pragma mark - Show Interstitial
/*!
 @abstract  InterstitialAd広告を表示
 @param     InController:コントロラー
 */
+(void) showInterstitial:(NSString*_Nonnull) placementId
            InController:(UIViewController* _Nonnull) controller;
/*!
 @abstract  InterstitialAd広告を表示
 @param     InController:コントロラー
 @param     WithDelegate:デリゲート
 */
+(void) showInterstitial:(NSString* _Nonnull) placementId
            InController:(UIViewController* _Nonnull) controller
            WithDelegate:(id<DLAdInterstitialStateDelegate> _Nullable) adStateDelegate;



@end
