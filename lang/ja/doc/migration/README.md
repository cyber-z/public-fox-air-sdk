# F.O.Xの計測機能とAPIについて

F.O.Xでは以下の４つの機能があります。
1. インストール計測
2. リエンゲージメント計測
3. LTV/イベント計測
4. セッション計測

## インストール計測

広告流入別にインストール数を計測します。
アプリ起動のタイミングで`trackInstall`を実行してください

## リエンゲージメント計測

リエンゲージメント広告をクリックしてアプリ起動した際に計測を行います。
具体的にはF.O.XのサーバからURLスキーマを使ってアプリを起動させます。
アプリ起動、または、アプリがバックグラウンドからフォアグラウンドになったタイミングでiOSは `[CYZFox handleOpenURL:url]`、Androidはは `Fox.trackDeeplinkLaunch`を実行してください。   

## LTV/イベント計測

広告成果に紐づくLTVやイベントを計測します（例：チュートリアル突破、課金など）。
イベントが発生したタイミングで `trackEvent`を実行してください。

## セッション計測

アプリ起動、または、アプリのバックグラウンドからフォアグランドになったタイミングでF.O.Xのサーバに起動通信を送ります。
アプリがフォアグラウンドになったタイミングで `trackSession`を実行してください。

# API対応表

## iOS
| 4.X機能 | ライフサイクル | 4.X Native API | 3.X Native API | 3.X AIR API | 関連URL |
| --- | --- | --- | --- | --- | --- |
| 初期化（activate） | didFinishLaunchingWithOptions | CYZFoxConfig* foxConfig = [CYZFoxConfig configWithAppId:4879<br>        salt:@"xxxxx" <br>        appKey:@"yyyyyy"];<br>[foxConfig activate];<br><br>[foxConfig enableDebugMode];<br>[foxConfig activate]; | AppAdForce.plistの記載項目:<br>APP_ID<br>APP_SALT<br>ANALYTICS_APP_KEY<br><br>サーバURLの設定も4.Xからは不要 | AppAdForce.plistの記載項目:<br>APP_ID<br>APP_SALT<br>ANALYTICS_APP_KEY<br><br>サーバURLの設定も4.Xからは不要 |  |
| インストール計測 | didFinishLaunchingWithOptions | [CYZFox trackInstall] | [adManager sendConversionWithStartpage:@default] | sendConversionWithStartPage() |  |
| リエンゲージメント計測 | application:(UIApplication *) application openURL:(nonnull NSURL *) url | [CYZFox handleOpenURL:url] | [adManager setUrlScheme:url] | sendReengagementConversion(String urlScheme):void |  |
| LTV/イベント計測 | 任意（イベント発生時） | // チュートリアル突破<br>[CYZFox trackEvent:[[CYZFoxEvent alloc] initWithEventName:@"Tutorial"]];<br><br>// 課金<br>CYZFoxEvent* event = [[CYZFoxEvent alloc] initWithEventName:@"purchase" ltvId:123];<br>event.price = 9.99;<br>event.currency = @"USD";<br>[CYZFox trackEvent:event]; | // アクセス解析によるチュートリアルとオパ<br>[AnalyticsManager sendEvent:@"Tutorial" action:nil label:nil value:0]<br><br>// LTVによるチュートリアル突破<br>[ltv addParameter:LTV_PARAM_PRICE :@"9.99"];<br>// LTVによる課金<br>[ltv addParameter:LTV_PARAM_CURRENCY :@"USD"]<br>[ltv sendLtv:123]<br><br>// アクセス解析による課金<br>[AnalyticsManager sendEvent:@"purchase" action:nil label:nil orderID:nil sku:nil itemName:nil price:9.99 quantity:1 currency:@"USD"; | 3.XではLTVとイベントが別でしたが4.Xからは統合されました。<br>LTV<br>ad.sendLtv(成果地点ID);<br>イベント<br>var obj:Object = {"a":"テスト", "buid":11111};<br>analytics.sendEvent(eventName, action, label, value, obj); |  |
| セッション計測 | application:didFinishLaunchingWithOptions:<br>applicationWillEnterForeground | [CYZFox trackSession]; | [ForceAnalyticsManager sendStartSession]; | private var analytics: AnalyticsManager = new AnalyticsManager ();<br>sendStartSession()void |  |



## Android
| 4.X機能 | ライフサイクル | 4.X Native API（手動実装API）<br>（自動計測は非対応） | 3.X Native API | 3.X AIR API | 関連URL |
| --- | --- | --- | --- | --- | --- |
| 初期化（activate） | onCreate | FoxConfig config = <br>new FoxConfig("APPADFORCE_APP_ID", "ANALYTICS_APP_KEY", "APPADFORCE_CRYPTO_SALT");<br>config.activate(); | AndroidManifest.xml<br><meta-data><br>・APPADFORCE_APP_ID<br>・APPADFORCE_CRYPTO_SALT<br>・ANALYTICS_APP_KEY<br><br>またサーバURLの設定も4.Xからは不要 | AndroidManifest.xml<br><meta-data><br>・APPADFORCE_APP_ID<br>・APPADFORCE_CRYPTO_SALT<br>・ANALYTICS_APP_KEY<br><br>またサーバURLの設定も4.Xからは不要 |  |
| インストール計測 | onCreate | FoxTrackOption opt = new FoxTrackOption();<br>opt.addRedirectUrl("https://redirectSite.com");<br>opt.addBuid("USER_0001")<br>Fox.trackInstall(opt); | AdManager ad = new AdManager( Context );<br>ad.sendConversion("default"); | sendConversionWithStartPage() | [インストール計測](https://github.com/forceoperationx/public-fox-android-sdk/blob/4.x/lang/ja/README.md#4-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E8%A8%88%E6%B8%AC%E3%81%AE%E5%AE%9F%E8%A3%85) |
| リエンゲージメント計測 | onResume | Fox.trackDeeplinkLaunch(Intent); | AdManager ad = new AdManager( Context );<br>ad.sendReengagementConversion(Intent); | sendReengagementConversion(String urlScheme):void | [リエンゲージメント計測](https://github.com/forceoperationx/public-fox-android-sdk/blob/4.x/lang/ja/README.md#5-%E3%83%AA%E3%82%A8%E3%83%B3%E3%82%B2%E3%83%BC%E3%82%B8%E3%83%A1%E3%83%B3%E3%83%88%E8%A8%88%E6%B8%AC%E3%81%AE%E5%AE%9F%E8%A3%85) |
| LTV/イベント計測 | 任意（イベント発生時） | // チュートリアル突破<br>FoxEvent event = new FoxEvent("チュートリアル完了");<br>Fox.trackEvent(event);<br><br>// 課金<br>FoxEvent event = new FoxEvent("イベント名", 成果地点ID);<br>event.price = 9.99;<br>event.currency = "USD";<br>event.quantity = 1;<br>Fox.trackEvent(event); | // アクセス解析によるチュートリアル突破<br>AnalyticsManager.sendEvent(Context, "チュートリアル完了", null, null, 1);<br><br>// LTV計測による課金計測<br>AdManager ad = new AdManager( Context )<br>LtvManager ltv = new LtvManager( ad );<br>ltv.addParam(LtvManager.URL_PARAM_PRICE, "9.99");<br>ltv.addParam(LtvManager.URL_PARAM_CURRENCY, "USD");<br>ltv.sendLtvConversion( 成果地点ID );<br><br>// アクセス解析による課金計測<br>AnalyticsManager.sendEvent(Context, "イベント名", action, null, null, orderId, sku, itemName, 9.99, 1, "USD"); | 3.XではLTVとイベントが別でしたが4.Xからは統合されました。<br>LTV<br>ad.sendLtv(成果地点ID);<br>イベント<br>var obj:Object = {"a":"テスト", "buid":11111};<br>analytics.sendEvent(eventName, action, label, value, obj); |[イベント計測](https://github.com/forceoperationx/public-fox-android-sdk/blob/4.x/lang/ja/README.md#62-%E3%81%9D%E3%81%AE%E4%BB%96%E3%81%AE%E3%82%A2%E3%83%97%E3%83%AA%E5%86%85%E3%82%A4%E3%83%99%E3%83%B3%E3%83%88%E3%81%AE%E8%A8%88%E6%B8%AC) |
| セッション計測 | onResume | Fox.trackSession(); | AnalyticsManager.sendStartSession( Context ); | private var analytics: AnalyticsManager = new AnalyticsManager ();<br>sendStartSession()void |[セッション計測](https://github.com/forceoperationx/public-fox-android-sdk/blob/4.x/lang/ja/README.md#61-%E3%82%BB%E3%83%83%E3%82%B7%E3%83%A7%E3%83%B3%E8%B5%B7%E5%8B%95%E3%82%A4%E3%83%99%E3%83%B3%E3%83%88%E3%81%AE%E8%A8%88%E6%B8%AC) |


## before

| F.O.X機能 | iOSの実行タイミング | iOS F.O.Xメソッド名（4.6.1） | Androidの実行タイミング | Android F.O.Xメソッド名（4.6.1） |   F.O.X AIR 3.X メソッド名 |
|:-----------|:------------|:------------|:------------|:------------|:------------|
| F.O.X初期化（activate） | `didFinishLaunchingWithOptions` | `[[CYZFoxConfig configWithAppId:0000 salt:@"xxxxx" appKey:@"xxxx"] activate];` | `onCreate` | ` int FOX_APP_ID = 発行されたアプリID;`<br>`String FOX_APP_KEY = "発行されたAPP_KEY";`<br>`String FOX_APP_SALT = "発行されたAPP_SALT";`<br>`FoxConfig config = new FoxConfig(this, FOX_APP_ID, FOX_APP_KEY, FOX_APP_SALT);`<br>`config.addDebugOption(BuildConfig.DEBUG).activate();` | なし。APIではなく3.Xではplistやmanifest.xmlに設定を行なっていたため。 |
| インストール計測 | `didFinishLaunchingWithOptions` | ` [CYZFox trackInstall];` | `onCreate` | `Fox.trackInstall();` | `sendConversionWithStartPage()` |
| リエンゲージメント計測 | `application:(UIApplication *) application openURL:(nonnull NSURL *) url` | `[CYZFox handleOpenURL:url];` | `onResume` | `Fox.trackDeeplinkLaunch` | `sendReengagementConversion(String urlScheme):void` |
| LTV/イベント計測 | 任意（イベント発生時） | チュートリアル突破<br>`CYZFoxEvent* event = [[CYZFoxEvent alloc] `<BR>`initWithEventName:@"_tutorial_comp" andLtvId:0000];`<br>`event.buid = @"User ID";`<br>`[CYZFox trackEvent:event];`<br>課金<br>`CYZFoxEvent* event = [[CYZFoxEvent alloc] initWithEventName:@"_purchase"];`<br>`event.price = 99;`<br>`event.currency = @"JPY";`<br>`event.sku = @"itemId";`<br>`[CYZFox trackEvent:event];` | 任意（イベント発生時） | チュートリアル突破<br>`FoxEvent tutorialEvent = new FoxEvent("_tutorial_comp", 成果地点ID);<br>tutorialEvent.buid = "ユーザーID";<br>Fox.trackEvent(tutorialEvent);`<br>課金<br>`FoxEvent purchaseEvent = new FoxEvent("_purchase", 成果地点ID);`<br>`purchaseEvent.price = 9.99;`<br>`purchaseEvent.currency = "USD";`<br>`purchaseEvent.sku = "ITEM_1";`<br>`Fox.trackEvent(purchaseEvent);`| 3.XではLTVとイベントが別でしたが4.Xからは統合されました。<br>LTV<br>`ad.sendLtv(成果地点ID);`<br>イベント<br>`var obj:Object = {"a":"テスト", "buid":11111};`<br>`analytics.sendEvent(eventName, action, label, value, obj);` | 
| セッション計測 |`application:didFinishLaunchingWithOptions:`<br>`applicationWillEnterForeground` | `[CYZFox trackSession];` | `onResume()` | `Fox.trackSession();` | `private var analytics: AnalyticsManager = new AnalyticsManager ();`<br>`sendStartSession()void`|  

# 参考資料

## Native SDK 3.X -> 4.X 移行ガイド
### iOS
https://github.com/forceoperationx/public-fox-ios-sdk/blob/4.x-master/lang/ja/doc/update/README.md
### Android
https://github.com/forceoperationx/public-fox-android-sdk/blob/4.x/lang/ja/doc/migration/README.md


## Native SDK Doc
### iOS
https://github.com/forceoperationx/public-fox-ios-sdk
### Android
https://github.com/forceoperationx/public-fox-android-sdk
### AIR
https://github.com/forceoperationx/public-fox-air-sdk


## Native SDK API List
### iOS
https://github.com/forceoperationx/public-fox-ios-sdk/blob/4.x-master/lang/ja/doc/sdk_api/README.md
### Android
https://github.com/forceoperationx/public-fox-android-sdk/blob/4.x/lang/ja/README.md#sdk_api

