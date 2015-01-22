#Androidに導入する

Flexプロジェクトに組み込まれたAIRアプリケーション記述子を編集します。
AIR アプリケーション記述子とはMXMLアプリケーションに対応する○○○-app.xmlの事です。

1. &lt;manifest&gt; ～ &lt;/ manifest&gt;内に、以下の設定を追加する。

		<uses-permission android:name="android.permission.INTERNET" />

2. &lt;application&gt; ～ &lt;/application&gt;内に、以下の設定を追加する。

		<receiver android:name="jp.appAdForce.android.InstallReceiver" android:exported="true">

3. &lt;application&gt; ～ &lt;/application&gt;内に、以下の設定を追加する。

		<meta-data android:name="APPADFORCE_APP_ID" android:value="1" />

> ▼ パラメーター<br>

![Androidへの導入](../../env_flashbuilder/ja/img009.png)

### 複数のInstallReceiverを共存させる場合の制限事項

※ 現在F.O.X AIRエクステンションは複数のエクステンションでのInstallReceiverの共存に対応していません。




		android:name="com.google.android.gms.version"
		android:value="@integer/google_play_services_version" />


アプリケーションの初回起動時にSDKが生成した識別IDをローカルストレージまたはSDカードに保存することで、アプリケーション再インストール時に重複判定を行うことができます。

本設定は必須ではありませんが、アプリケーションの再インストールにおける重複検知の精度が大きく向上するため、実装を推奨しております。

### パーミッションの設定

外部ストレージへのファイル読み書きに必要なパーミッションの設定をAndroidManifest.xmlの&lt;manifest&gt;タグ内に追加します。

```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
```

上記パーミッションが設定されている場合、次のパスに識別IDファイルが保存されます。

```
Environment.getExternalStorageDirectory().getPath()で取得できるパス/アプリのパッケージ名/__FOX_XUNIQ__
```

### （任意）保存ディレクトリ及びファイル名の変更

保存されるファイルのディレクトリ名は、標準ではパッケージ名で作成されますが、&lt;application&gt;タグ内に以下設定を追加することで、任意のディレクトリ名及びファイル名に変更することができます。

```xml
<meta-data android:name="APPADFORCE_ID_DIR" android:value="任意のディレクトリ名" />
<meta-data android:name="APPADFORCE_ID_FILE" android:value="任意のファイル名" />
```

> 任意のディレクトリ名やファイル名を指定した場合でも、Environment.getExternalStorageDirectory().getPath()の返り値のパス配下に作成します。Environment.getExternalStorageDirectory().getPath()の返り値は端末やOSバージョンによって異なります。 
> "APPADFORCE_ID_DIR"(任意のディレクトリ名)を指定せず、任意のファイル名のみを指定した場合、アプリのパッケージ名のディレクトリが作成され、その配下に任意のファイル名で保存されます。 
> ※"APPADFORCE_ID_FILE"(任意のファイル名)を指定せず、任意のディレクトリ名のみを指定した場合、任意の名前でディレクトリが作成され、その配下に"__FOX_XUNIQ__"で保存されます。
通常は設定の必要はありません。


### 設定例

AndroidManifest.xmlの設定例を次に記載します。

```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />

<application 
	android:icon="@drawable/ic_launcher"
	android:label="@string/app_name" >
	
	<meta-data android:name="APPADFORCE_ID_DIR" android:value="fox_id_dir" />
	<meta-data android:name="APPADFORCE_ID_FILE" android:value="fox_id_file" />
	
</application>

```

上記の例の場合に、保存されるファイルのパスは次になります。

	Environment.getExternalStorageDirectory().getPath()で取得できるパス/fox_id_dir/fox_id_file


### 外部ストレージの利用停止

Force Operation X SDKによる外部ストレージへのアクセスを停止したい場合には、AndroidManifest.xmlにAPPADFORCE_USE_EXTERNAL_STORAGEの設定を追加してください。

<meta-data android:name="APPADFORCE_USE_EXTERNAL_STORAGE" android:value="0" />
```

本設定を行うことで外部ストレージに対する記録が停止しますが、アプリケーションの削除によりデータが常に初期化されるため、正確なインストール計測が行われなくなります。