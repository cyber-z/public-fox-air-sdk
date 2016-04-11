# iOSに導入する

###AppAdForce.plistの編集
1. AppAdForce.plistを追加<br>
Xcodeでplistファイルを作成します。<br>AppAdForce.plistのファイル名にします。
2. AppAdForce.plistを編集<br>
作成したAppAdForce.plistを選択し、次のKeyおよびValueを追加します。

|#|キー名|タイプ|値|
|:---:|:---|:---|:---|
|1|APP_ID|String|Force Operation X管理者より連絡いたしますので、その値を入力してください。|
|2|SERVER_URL|String|Force Operation X管理者より連絡いたしますので、その値を入力してください。|
|3|APP_OPTIONS|String|空白のままにしてください。|
|4|APP_VERSION|String|バージョンを整数で入力してください。|
|5|CONVERSION_MODE|String|1 : FOXバージョン管理ブラウザ制御<br>1を入力してください。|
|6|APP_SALT|String|Force Operation X管理者より連絡いたしますので、その値を入力してください。|

> ※CONVERSION_MODEは外部ブラウザの制御に使用します。<br>
> “0”はユーザに確認画面を表示します。<br>> “1”はFOXの管理画面でブラウザ成果の制御を行えます。<br>
> “2”はブラウザでの成果を取得せず、後述のURLスキーマ起動での成果取得を行います。

AppAdForce.plist

![iOSへの導入](/lang/ja/doc/env_flashbuilder/img008.png)

---
[トップ](/lang/ja/README.md)
