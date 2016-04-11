#import "FlashRuntimeExtensions.h"
#import "DLBannerView.h"
#import "DLAdStateDelegate.h"

@interface DLABannerView : NSObject <DLAdStateDelegate>

@property DLBannerView* bannerView;
@property FREContext ctx;

@end
