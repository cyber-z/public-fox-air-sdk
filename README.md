# Force Opetaion Xとは

Force Operation X (以下F.O.X)は、スマートフォンにおける広告効果最適化のためのトータルソリューションプラットフォームです。アプリケーションのダウンロード、ウェブ上でのユーザーアクションの計測はもちろん、スマートフォンユーザーの行動特性に基づいた独自の効果計測基準の元、企業のプロモーションにおける費用対効果を最大化することができます。

本ドキュメントでは、スマートフォンアプリケーションにおける広告効果最大化のためのF.O.X SDK導入手順について説明します。

## F.O.X SDKとは

F.O.X SDKをアプリケーションに導入することで、以下の機能を実現します。

* **インストール計測**

広告流入別にインストール数を計測することができます。

* **LTV計測**

流入元広告別にLife Time Valueを計測します。主な成果地点としては、会員登録、チュートリアル突破、課金などがあります。各広告別に登録率、課金率や課金額などを計測することができます。

* **アクセス解析**

自然流入と広告流入のインストール比較。アプリケーションの起動数やユニークユーザー数(DAU/MAU)。継続率等を計測することができます。


# 1.	概要

本ドキュメントでは、Force Operation X SDK Airエクステンションの導入手順について説明します。Force Operation X SDK AirエクステンションはiOSおよびAndroidに対応しています。


|処理|必須|概要|
|:------:|:------:|:------|
|LTV計測|オプション|任意の成果地点で成果通知を行い、広告別の課金数や入会数の計測を行います。<br>課金金額、退会数などを測定することができます。<br>メソッド名：sendLtv|
|アクセス解析|オプション|アプリの起動時およびバックグラウンドからの復帰時の起動計測を行います。<br>起動数、アクティブユーザー数(DAU)、継続率などを測定することができます。<br>メソッド名：sendStartSession|

|:----|:----|
|withGooglePlayServices/AppAdForceExtension.ane|Google Play Services, version 4.4 (4452000) ライブラリを内包しています。|

## 1.3 Adobe AIR SDK サポートバージョン

* Google Play Services非内包版：Adobe AIR SDK 3.5 以上



3. Flexプロジェクト上で、右クリック→「プロパティー」を選択する。
4. 左側に見えるツリーから「Flexビルドパス」を選択する。
![ライブラリの組み込み手順](./doc/env_flashbuilder/ja/img003.png)
8. AIRアプリケーション記述子を更新にチェックを付けたままOKボタンを押下する。
9. メイン画面に「AppAdForceExtension.ane」が表示されていることを確認する。




2. 右側のメイン画面にある「ネイティブエクステンション」タブを選択する。

2. 右側のメイン画面にある「ネイティブエクステンション」タブを選択する。


		import jp.appAdForce.AdLtvManager;





### ・[Androidの設定](./doc/setting_android/ja/README.md)


# 3 Airエクステンション導入手順(Flash)

## 3.1 Airエクステンションをプロジェクトに追加
※ここではIDEにFlashを使用して説明いたします。

![Flash](./doc/env_flash/ja/img001.png)<br>

1. Flashを起動して、「Air for iOS」プロジェクトを選択する。
 
2. AppAdForceExtension_vX.X.X.aneをライブラリパスに配置する。<br>
![iOSプロジェクト](./doc/env_flash/ja/img002.png)<br>
・「+」を押下し新規パスを追加する。<br>
・ネイティブ拡張ボタンを押下する。<br>

3. アプリケーション設定から含めるファイルに後述のAppAdForce.plistを追加する。<br>
![iOSプロジェクト](./doc/env_flash/ja/img003.png)<br>

4. 「ファイル」→「パブリッシュ」を選択し証明書、プロビジョニングプロファイルを環境に合わせて設定する。

5. パブリッシュボタンを押下しパブリッシュを実行

## 3.2 コードの編集

コードの編集は、ActionScriptに行います。

1. jp.appAdForce.AdLtvManagerクラスをインポートする。

		import jp.appAdForce.AdLtvManager;

2. AppAdForceをインスタンス宣言する。

		private var ad:AdLtvManager = new AdLtvManager();


![iOSプロジェクト](./doc/env_flash/ja/img004.png)<br><br>
3. 成果計測用のソースをアプリケーションに追加する<br>
※ここではマウスクリックイベントに埋め込んだサンプルを紹介します。

![iOSプロジェクト](./doc/env_flash/ja/img005.png)<br><br>

sendConversionWithStartPage関数の引数はURLになります。



##### 【起動時以外で成果計測を行いたい場合】
起動時以外のタイミングでブラウザを開き、そのタイミングで成果計測を行いたい場合には


## 3.3 設定ファイルの編集
OSによって手順が異なります。

### ・[iOSの設定](./doc/setting_ios/ja/README.md)
### ・[Androidの設定](./doc/setting_android/ja/README.md)


# 4 LTV計測の実装

## 4.1 LTV計測概要

##### ・LTVの定義
Force Operation X内でのLTVとは、“アプリDL後のアクション”を指します。

##### ・LTV地点について
主にアプリ内課金、資料請求、会員登録、商品購入など広告におけるCV地点になりますが、“ユーザー”のアクション地点であれば、自由にご設定頂くことが可能です。<br>

##### ・LTV地点の登録数について
複数地点での登録が可能になります。<br>

LTV計測により、広告流入別の課金金額や入会数などを計測することができます。計測のために、任意の地点にLTV成果通信を行うコードを追加します。

## 4.2 コードの編集

コードの編集は、通常、成果が上がった後に実行されるMXMLアプリケーションに処理を記述します。例えば、会員登録やアプリ内課金後の課金計測では、登録・課金処理実行後のコールバック内にLTV計測処理を記述します。

1. jp.appAdForce.AdLtvManagerクラスをインポート

		import jp.appAdForce.AdLtvManager;

2. LTV計測処理を行うオブジェクトの生成

		AdLtvManager ad = new AdLtvManager()

3. 計測種類に応じた設定を行う<br>
以下、計測種類に応じて組み込んでください。

######<アプリ内でLTV計測を行う><br>
成果がアプリ内部で発生する場合、成果処理部に以下のように記述してください。

	ad.sendLtv(成果地点ID);

成果地点ID(必須)：管理者より連絡します。その値を入力してください。


######<アプリ内でLTV計測を行う（広告主端末IDあり）><br>
アプリ内部の成果に、広告主端末ID（会員IDなど）を含める事ができ、これを基準とした成果計測が行えます。

	ad.sendLtvWithAdid(成果地点ID, “広告主端末ID”);


成果地点ID(必須)：管理者より連絡します。その値を入力してください。

	ad.addParameter(“パラメータ名”, “値”);


▼ オプション

|パラメータ名|概要|
|:------|:------|
|AdLtvManager.PARAM_SKU|Stock Keeping Unit(商品管理コード)<br>（半角英数字32文字まで）<br>商品の在庫管理する際に使用してください|
|AdLtvManager.PARAM_PRICE|Price<br>（整数値　日本円）<br>売上額を管理する際に使用してください。|
|任意でパラメータを加える事も可能です。|Currency<br>（半角英字3文字の通貨コード）<br>通貨別で課金額を集計する際に使用してください。<br>通貨が設定されていない場合、PriceをJPY(日本円)として扱います。|ad.addParameter (“任意のパラメータ名”, 値);<br>※1アンダースコア（”_”）をパラメータ名の先頭に記述しないでください。<br>※2同一パラメータ名を記述した場合は、後者が有効となります。<br>※3 半角英数字以外は使用できません。

＜オプションの使用例＞

	ad.addParameter (AdLtvManager.PARAM_SKU, “ABC1234”);

## 4.3 動作確認

動作テストを実施する際は、インストール計測（インストールからアプリ起動時の成果計測）実行後、アプリ上で成果地点に到達してください。インストール計測において成果がない場合にはLTV計測が行われません。


# 5 アクセス解析

## 5.1 アクセス解析について

・広告効果測定ツール『Force Operation X』(以下F.O.X)のアドオン機能

## 5.2 アクセス解析SDK導入の流れ

アクセス解析を行うには、ソースの編集が必要になります。

全体の流れは、以下のようになります。

ソースの編集

1. プジェクとにライブラリを追加
2. app.xmlにANALYTICS_APP_KEYを追加(Android)<br>
AppAdForce.plistにANALYTICS_APP_KEYを追加(iOS)
3. ソースコードを編集し、セッション開始のコードを追加

動作確認

## 5.3 コードの編集
コードの編集は、通常全てのMXMLアプリケーションに行います。

1. jp.appAdForce.AnalyticsManagerクラスをインポートする。

		import jp.appAdForce.analyticsManager;

2. AnalyticsManagerをインスタンス宣言する。

		private var analytics: AnalyticsManager = new AnalyticsManager ();


## 5.4 AIRアプリケーション記述子の編集 (Android版のみ)

Flexプロジェクトに組み込まれたAIR アプリケーション記述子を編集します。

・&lt;application&gt; ～ &lt;/application&gt;内に、以下の設定を追加する。

	<meta-data android:name="ANALYTICS_APP_KEY" android:value="***" />

> ANALYTICS_APP_KEY ⇒ Force Operation X管理者より連絡します。

## 5.5	AppAdForce.plistの編集 (iOS版のみ)

AppAdForce.plistを編集します。

Force Operation Xの導入時に作成したAppAdForce.plistを選択し、次のKeyおよびValueを追加します。

|#|キー名|タイプ|値|
|:---:|:---|:---|:---|
|1|ANALYTICS_APP_KEY|String|Force Operation X管理者より連絡いたしますので、その値を入力してください|
|2|ANALYTICS_QUEUE_INTERVAL|Number|(オプション)<br>イベントログの送信間隔(秒)。<br>0でイベント発生時に即時送信。<br>設定しなかった場合にはイベント発生時、データはキューに保持され、デフォルト値の60秒ごとに送信します。<br>トラッキング地点を多く設定し、イベントが頻繁に発生する場合には、送信間隔を多めにすることでイベントログが定期的に一度の通信でまとめて送られるため、頻繁な通信を抑制できます。|


## 5.6 起動計測を行う

アプリケーション起動時やバックグラウンド状態からの復帰時等、セッションの開始を計測します。
広告ごとのアクティブユーザー数、起動時間、リテンション等を分析できます。

|API|概要|
|:---:|:---:|
|sendStartSession()void|アプリケーションの起動やバックグラウンドからの復帰を計測|



######※mxmlファイルを複数利用している場合はmxmlファイル毎に以下のような計測処理の記述が必要です。
<実装サンプル>

	<s:Application xmlns:fx="http://ns.adobe.com/mxml/2009"　 xmlns:s="library://ns.adobe.com/flex/spark" applicationComplete="foxInitialize(event)">


|:---|:---:|:---:|:---:|:---|
|eventName|String|255|必須|トラッキングを行うイベントを識別できる任意の名前を設定します。<br>イベント名は自由に設定可能です。<br>イベント単位でグルーピングされ、それぞれのイベントごとに集計を行うことができます。|
|label|String|255|オプション|アクションに属するラベル名を設定します。<br>ラベル名は自由に設定可能です。<br>各アクションをドリルダウンすることで、ラベルごとに集計を行うことができます。<br>特に指定しない場合は””を設定してください。|
|sku|String|255|オプション|商品コード。特に指定しない場合は””を設定してください。|
|quantity|int||必須|購入数|


## 6.1 リエンゲージメント計測API

|:---:|:---:|
|sendReengagementConversion(String urlScheme):void|リエンゲージメント広告経由で起動したユーザーの成果を計測|






3. 弊社より発行したテスト用URLをクリック<br>
   ※ テスト用URLは必ずOSに設定されているデフォルトブラウザでリクエストされるようにしてください。
   ※ テストURLの場合には、遷移先がなくエラーダイアログが表示される場合がありますが、問題ありません。
6. アプリを起動、ブラウザが起動<br>
   ※ ここでブラウザが起動しない場合には、正常に設定が行われていません。
8. アプリを終了し、バックグラウンドからも削除
9. 再度アプリを起動
10. 弊社へ3,6,7,9の時間をお伝えください。正常に計測が行われているか確認致します。
11. 弊社側の確認にて問題がなければテスト完了となります。






* [(Android)広告IDの利用/重複排除の設定](./doc/setting_android/ja/README.md)