## LTV成果計測の詳細

######<アプリ内でLTV計測を行う（広告主端末IDあり）><br>
アプリ内部の成果に、広告主端末ID（会員IDなど）を含める事ができ、これを基準とした成果計測が行えます。以下のように記述してください。

	ad.sendLtvWithAdid(成果地点ID, “広告主端末ID”);


成果地点ID(必須)：管理者より連絡します。その値を入力してください。広告主端末ID(オプション)：広告主様が管理しているユニークな識別子（会員IDなど）です。######【アプリ内計測時(A/B)に設定する事が可能なオプション】アプリ内計測時には、下記パラメータもオプションとして設定する事が可能です。＜オプションの設定例＞

	ad.addParameter(“パラメータ名”, “値”);


▼ オプション

|パラメータ名|概要|
|:------|:------|
|AdLtvManager.PARAM_SKU|Stock Keeping Unit(商品管理コード)<br>（半角英数字32文字まで）<br>商品の在庫管理する際に使用してください|
|AdLtvManager.PARAM_PRICE|Price<br>（整数値　日本円）<br>売上額を管理する際に使用してください。|
|AdLtvManager.PARAM_CURRENCY|Currency<br>（半角英字3文字の通貨コード）<br>通貨別で課金額を集計する際に使用してください。<br>通貨が設定されていない場合、PriceをJPY(日本円)として扱います。|
|任意でパラメータを加える事も可能です。|ad.addParameter (“任意のパラメータ名”, 値);<br>※1アンダースコア（”_”）をパラメータ名の先頭に記述しないでください。<br>※2同一パラメータ名を記述した場合は、後者が有効となります。<br>※3 半角英数字以外は使用できません。|

＜オプションの使用例＞

```as3
	ad.addParameter (AdLtvManager.PARAM_SKU, “ABC1234”);	ad.addParameter (AdLtvManager.PARAM_PRICE, “2000”);	ad.addParameter (“my_param”, “ABC”);	ad.sendLtvWithAdid (70, “Taro”);
```

---
[トップ](/lang/ja/README.md)
