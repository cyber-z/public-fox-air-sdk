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
アプリ停止状態とアプリがバックグラウンドに残っている場合のそれぞれで `[CYZFox handleOpenURL:url]`または `Fox.trackDeeplinkLaunch`を実行してください。

## LTV/イベント計測

広告成果に紐づくLTVやイベントを計測します（例：チュートリアル突破、課金など）。
イベントが発生したタイミングで `trackEvent`を実行してください。

## セッション計測

アプリ起動、アプリのバックグラウンド復帰のタイミングでF.O.Xのサーバに起動通信を送ります。
アプリがフォアグラウンドになったタイミングで `trackSession`を実行してください。

# 対応表

| F.O.X機能 | iOSの実行タイミング | iOS F.O.Xメソッド名（4.6.1） | Androidの実行タイミング | Android F.O.Xメソッド名（4.6.1） |   F.O.X AIR 3.X メソッド名 |
|:-----------|:------------|:------------|:------------|:------------|:------------|
| F.O.X初期化（activate） | `didFinishLaunchingWithOptions` | `[[CYZFoxConfig configWithAppId:0000 salt:@"xxxxx" appKey:@"xxxx"] activate];` | `onCreate` | ` int FOX_APP_ID = 発行されたアプリID;`<br>`String FOX_APP_KEY = "発行されたAPP_KEY";`<br>`String FOX_APP_SALT = "発行されたAPP_SALT";`<br>`FoxConfig config = new FoxConfig(this, FOX_APP_ID, FOX_APP_KEY, FOX_APP_SALT);`<br>`config.addDebugOption(BuildConfig.DEBUG).activate();` | `private var ad:AdLtvManager = new AdLtvManager();` |
| インストール計測 | `didFinishLaunchingWithOptions` | ` [CYZFox trackInstall];` | `onCreate` | `Fox.trackInstall();` | `sendConversionWithStartPage()` |
| リエンゲージメント計測 | `application:(UIApplication *) application openURL:(nonnull NSURL *) url` | `[CYZFox handleOpenURL:url];` | `onResume` | `Fox.trackDeeplinkLaunch` | `sendReengagementConversion(String urlScheme):void` |
| LTV/イベント計測 | 任意（イベント発生時） | `CYZFoxEvent* event = [[CYZFoxEvent alloc] `<BR>`initWithEventName:@"_tutorial_comp" andLtvId:0000];`<br>`event.buid = @"User ID";`<br>`[CYZFox trackEvent:event];` | 任意（イベント発生時） | `FoxEvent tutorialEvent = new FoxEvent("_tutorial_comp", 成果地点ID);<br>tutorialEvent.buid = "ユーザーID";<br>Fox.trackEvent(tutorialEvent);`| 3.XではLTVとイベントが別でしたが4.Xからは統合されました。<br>LTV<br>`ad.sendLtv(成果地点ID);`<br>イベント<br>`var obj:Object = {"a":"テスト", "buid":11111};`<br>`analytics.sendEvent(eventName, action, label, value, obj);` | 
| セッション計測 |`application:didFinishLaunchingWithOptions:`<br>`applicationWillEnterForeground` | `[CYZFox trackSession];` | `onResume()` | `Fox.trackSession();` | `private var analytics: AnalyticsManager = new AnalyticsManager ();`<br>`sendStartSession()void`|  

# 参考資料
## Native SDK
iOS 
https://github.com/forceoperationx/public-fox-ios-sdk

Android
https://github.com/forceoperationx/public-fox-android-sdk

AIR
https://github.com/forceoperationx/public-fox-air-sdk

