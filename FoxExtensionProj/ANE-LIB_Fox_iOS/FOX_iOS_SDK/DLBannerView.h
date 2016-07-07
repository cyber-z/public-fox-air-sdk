//
//  DLBannerView.h
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
 @Class    DLBannerView
 @abstract Ad広告を表示するViewの管理
 */

typedef NS_ENUM (NSUInteger, DLBannerPosition) {
    DL_BANNER_POSITION_TOP = 1,
    DL_BANNER_POSITION_BOTTOM = 2,
    DL_BANNER_POSITION_TOP_LEFT = 3,
    DL_BANNER_POSITION_TOP_RIGHT = 4,
    DL_BANNER_POSITION_BOTTOM_LEFT = 5,
    DL_BANNER_POSITION_BOTTOM_RIGHT = 6,
};

@interface DLBannerView : UIView

@property NSString* _Nonnull placementId;
@property DLBannerPosition position;
@property (weak) id<DLAdStateDelegate> _Nullable adStateDelegate;

#pragma mark - BannerView Show/Dismiss (Public)
/*!
 @abstract  AD広告表表示 (Public)
 */
-(void) show;
/*!
 @abstract  AD広告非表示 (Public)
 */
-(void) dismissView;


#pragma mark - Trigger Success/Failed (Protected)
/*!
 @abstract  ロードが成功した時のトリガー
 */
-(void) triggerLoadSuccess;
/*!
 @abstract  ロードが失敗した時のトリガー
 */
-(void) triggerLoadFailed;

@end
