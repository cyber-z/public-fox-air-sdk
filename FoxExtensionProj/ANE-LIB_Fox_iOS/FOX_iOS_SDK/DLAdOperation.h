//
//  DLAdOperationManager.h
//  DahliaSdkCore
//
//  Created by MMizogaki on 6/2/16.
//  Copyright © 2016 CyberZ. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/*!
 @Class    DLAdOperation
 @abstract 広告表示に必要なデータを取得または送信を管理する
 */

@interface DLAdOperation : NSObject

#pragma mark - typedef callback function
/*!
 @abstract  成功時のコールバック
 @param    receiveObject:受け取るjson
 */
typedef void (^FOXOnReceiveAdInfo)(NSDictionary * _Nonnull receiveObject);
/*!
 @abstract  失敗時のコールバック
 */
typedef void (^FOXOnRequestFailed)();


#pragma mark - Ad Info Reqest
/*!
 @abstract  広告情報をリクエストして受け取ったJsonを返す
 @param     placementId:ユニークなID
 @param     success:受け取ったJsonをコールバック
 @param     failure:失敗時のコールバック
 */
-(void) requestAdInfo:(NSString* _Nonnull) placementId
              success:(_Nonnull FOXOnReceiveAdInfo) successHandler
              failure:(_Nullable FOXOnRequestFailed) failureHandler;


#pragma mark - Send Imp/Chick
/*!
 @abstract  広告情報が表示されたかを送る
 @param     placementId:ユニークなID
 @param     impStatus:広告が表示されたかを判定
 @param     sessionId:リクエストして受け取ったID
 */
+(void) sendImp:(NSString* _Nonnull) placementId
      impStatus:(BOOL) impStatus
      sessionId:(NSString* _Nonnull) sessionId;
/*!
 @abstract  広告がクリックされた時に送る
 @param     placementId:ユニークなID
 @param     sessionId:リクエストして受け取ったID
 */
+(void) sendClick:(NSString* _Nonnull) placementId
        sessionId:(NSString* _Nonnull) sessionId;

@end
