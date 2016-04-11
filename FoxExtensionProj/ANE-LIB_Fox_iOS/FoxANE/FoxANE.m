//
//  FoxANE.m
//  FoxANE
//
//  Created by cyberz0021 on 12/12/18.
//  Copyright (c) 2012年 cyberz0021. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FlashRuntimeExtensions.h"
#import "AdManager.h"
#import "Ltv.h"
#import "AnalyticsManager.h"
#import "DLABannerView.h"
#import "DLAInterstitial.h"

#pragma mark - utility
static NSMutableDictionary* parms = nil;

NSString* FREObject2String(FREObject arg)
{
    uint32_t length;
    const uint8_t *param;
    FREGetObjectAsUTF8(arg, &length, &param);
    NSString* str = [NSString stringWithUTF8String:(char*)param];
    return str;
}

int32_t FREObject2Int(FREObject arg)
{
    int32_t num;
    FREGetObjectAsInt32(arg, &num);
    return num;
}

double FREObject2Double(FREObject arg)
{
    double num;
    FREGetObjectAsDouble(arg, &num);
    return num;
}

static UIViewController* DLAGetRootViewController() {
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

#pragma mark - AdManager

FREObject sendConversion(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    
    NSLog(@"start sendConversion");
    NSLog(@"argc %d",argc);
    
    [[AppAdForceManager sharedManager]sendConversionWithStartPage:@"default"];
    return NULL;
}

FREObject sendConversionWithStartPage(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    
    NSLog(@"start sendConversionWithStartPage");
    NSLog(@"argc %d",argc);
    
    if (argc == 1) {
        NSString* _url = FREObject2String(argv[0]);
        [[AppAdForceManager sharedManager]sendConversionWithStartPage:_url];
    } else if(argc == 2){
        NSString* _url = FREObject2String(argv[0]);
        NSString* _buid = FREObject2String(argv[1]);
        [[AppAdForceManager sharedManager]sendConversionWithStartPage:_url buid:_buid];
    }
    return NULL;
}

FREObject sendReengagementConversion(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    if (argc == 1) {
        NSString* _urlScheme = FREObject2String(argv[0]);
        [[AppAdForceManager sharedManager]setUrlScheme:[NSURL URLWithString:_urlScheme]];
    }
    return NULL;
}


FREObject sendLtv(FREContext ctx,void* funcData, uint32_t argc, FREObject argv[]){
    
    NSLog(@"start sendLtv");
    NSLog(@"argc %d",argc);
    
    int32_t cvpoint = FREObject2Int(argv[0]);
    NSLog(@"argv[0] is %d",cvpoint);
    
    AppAdForceLtv *ltv = [[AppAdForceLtv alloc] init];
    for (id key in parms) {
        [ltv addParameter:key :[parms objectForKey:key]];
    }
    [ltv sendLtv:cvpoint];
    
    [parms removeAllObjects];
    return NULL;
}

//sendLtvWithAdid
FREObject sendLtvWithAdid(FREContext ctx,void* funcData, uint32_t argc, FREObject argv[]){
    
    NSLog(@"start sendLtv");
    NSLog(@"argc %d",argc);
    
    int32_t cvpoint = FREObject2Int(argv[0]);
    NSLog(@"argv[0] is %d",cvpoint);
    NSString* buid = FREObject2String(argv[1]);
    NSLog(@"argv[1] is %@",buid);
    
    AppAdForceLtv *ltv = [[AppAdForceLtv alloc] init];
    for (id key in parms) {
        [ltv addParameter:key :[parms objectForKey:key]];
    }
    
    [ltv sendLtv:cvpoint :buid];
    
    [parms removeAllObjects];
    return NULL;
}

// addParameter
FREObject addParameter(FREContext ctx,void* funcData, uint32_t argc, FREObject argv[]){
    
    NSLog(@"start addParameter");
    NSString* name = FREObject2String(argv[0]);
    NSLog(@"argv[0] is %@",name);
    NSString* val = FREObject2String(argv[1]);
    NSLog(@"argv[1] is %@",val);
    
    if (parms == nil) {
        parms = [[NSMutableDictionary alloc]init];
    }
    [parms setObject:val forKey:name];
    return NULL;
}

# pragma mark - Analytics
/**
 * sendStartSession
 */
FREObject sendStartSession(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    [ForceAnalyticsManager sendStartSession];
    return NULL;
}

/**
 * sendEndSession
 */
FREObject sendEndSession(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    [ForceAnalyticsManager sendEndSession];
    return NULL;
}

/**
 * sendEvent
 */
FREObject sendEvent(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    NSString* _eventName = FREObject2String(argv[0]);
    NSString* _action    = FREObject2String(argv[1]);
    NSString* _label     = FREObject2String(argv[2]);
    int32_t   _value     = FREObject2Int(argv[3]);
    
    [ForceAnalyticsManager sendEvent:_eventName action:_action label:_label value:_value];
    return NULL;
}

/**
 * sendEventPurchase
 */
FREObject sendEventPurchase(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    NSString* _eventName = FREObject2String(argv[0]);
    NSString* _action    = FREObject2String(argv[1]);
    NSString* _label     = FREObject2String(argv[2]);
    NSString* _orderID   = FREObject2String(argv[3]);
    NSString* _sku       = FREObject2String(argv[4]);
    NSString* _itemName  = FREObject2String(argv[5]);
    double    _price     = FREObject2Double(argv[6]);
    int32_t   _quantity  = FREObject2Int(argv[7]);
    NSString* _currency  = FREObject2String(argv[8]);
    
    [ForceAnalyticsManager sendEvent:_eventName action:_action label:_label orderID:_orderID sku:_sku itemName:_itemName price:_price quantity:_quantity currency:_currency];
    return NULL;
}

# pragma mark - Dahlia

FREObject DLACreateBannerView(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    
    NSLog(@"start createBannerView");
    NSLog(@"DLACreateBannerView context %p", ctx);
    
    DLABannerView* bannerViewImp = [DLABannerView new];
    bannerViewImp.ctx = ctx;
    
    DLBannerView* bannerView = [DLBannerView new];
    bannerView.adStateDelegate = bannerViewImp;
    
    bannerViewImp.bannerView = bannerView;
    return (__bridge_retained FREObject) bannerViewImp;
}


FREObject DLAShowBanner(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    
    NSLog(@"start showBanner");
    NSLog(@"argc %d",argc);
    DLABannerView* bannerViewImp = (__bridge DLABannerView*) argv[0];
    NSString* placementId = FREObject2String(argv[1]);
    DLBannerPosition position = FREObject2Int(argv[2]);
    
    if (bannerViewImp) {
        bannerViewImp.bannerView.placementId = placementId;
        bannerViewImp.bannerView.position = position;
        [DLAGetRootViewController().view addSubview:bannerViewImp.bannerView];
        [bannerViewImp.bannerView show];
    }
    
    return NULL;
}

FREObject DLAHideBanner(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    NSLog(@"DLAHideBanner");
    
    DLABannerView* bannerViewImp = (__bridge DLABannerView*) argv[0];
    [bannerViewImp.bannerView dismissView];
    
    return NULL;
}


FREObject DLACreateInterstitial(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    
    NSLog(@"start createInterstitial");
    DLAInterstitial* interstitialImp = [DLAInterstitial new];
    interstitialImp.ctx = ctx;
    
    return (__bridge_retained FREObject) interstitialImp;
}


FREObject DLAShowInterstitial(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    
    NSLog(@"start show");
    NSLog(@"argc %d",argc);
    DLAInterstitial* interstitialImp = (__bridge DLAInterstitial*) argv[0];
    NSString* placementId = FREObject2String(argv[1]);
    
    [DLInterstitialViewController showInterstitial:placementId
                                      InController:DLAGetRootViewController()
                                      WithDelegate:interstitialImp];
    
    return NULL;
}


# pragma mark - Air Context
void FoxContextFinalizer(FREContext ctx) {
    
    NSLog(@"start ContextFinalizer");
    // Nothing to clean up.
    NSLog(@"end ContextFinalizer");
    
    return;
}

void FoxContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx,
                        uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) {
    
    NSLog(@"start ContextInitializer");
    
    static FRENamedFunction funcList[] = {
        // AdManager
        {
            (const uint8_t*) "sendConversion",
            NULL,
            &sendConversion
        },
        {
            (const uint8_t*) "sendConversionWithStartPage",
            NULL,
            &sendConversionWithStartPage
        },
        {
            (const uint8_t*) "sendReengagementConversion",
            NULL,
            &sendReengagementConversion
        },
        {
            (const uint8_t*) "addParameter",
            NULL,
            &addParameter
        },
        {
            (const uint8_t*) "sendLtv",
            NULL,
            &sendLtv
        },
        {
            (const uint8_t*) "sendLtvWithAdid",
            NULL,
            &sendLtvWithAdid
        },
        // Analytics
        {
            (const uint8_t*) "sendStartSession",
            NULL,
            &sendStartSession
        },
        {
            (const uint8_t*) "sendEndSession",
            NULL,
            &sendEndSession
        },
        {
            (const uint8_t*) "sendEvent",
            NULL,
            &sendEvent
        },
        {
            (const uint8_t*) "sendEventPurchase",
            NULL,
            &sendEventPurchase
        },
        // Banner
        {
            (const uint8_t*) "createBannerView",
            NULL,
            &DLACreateBannerView
        },
        {
            (const uint8_t*) "showBanner",
            NULL,
            &DLAShowBanner
        },
        {
            (const uint8_t*) "hideBanner",
            NULL,
            &DLAHideBanner
        },
        // Interstitial
        {
            (const uint8_t*) "createInterstitial",
            NULL,
            &DLACreateInterstitial
        },
        {
            (const uint8_t*) "showInterstitial",
            NULL,
            &DLAShowInterstitial
        },
    };
    
    *numFunctionsToTest = sizeof(funcList) / sizeof(FRENamedFunction);
    *functionsToSet = funcList;
    
    NSLog(@"end ContextInitializer()");
    
}

FREObject foxFinalize(FREContext context, void* funcData,uint32_t argc, FREObject argv[]){
    NSLog(@"start foxFinalize");
    return NULL;
}

void foxInitilize(void** extDataToSet, FREContextInitializer* ctxInitializerToSet,
                  FREContextFinalizer* ctxFinalizerToSet) {
    
    NSLog(@"start foxInitilize");
    *extDataToSet = NULL;
    *ctxInitializerToSet = &FoxContextInitializer;
    *ctxFinalizerToSet = &FoxContextFinalizer;
    NSLog(@"end ExtInitializer()");
}
