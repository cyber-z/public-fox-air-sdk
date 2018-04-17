package jp.appAdForce.android.ane;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;

import java.util.HashMap;
import java.util.Map;

import jp.appAdForce.android.ane.functions.AdManagerFunctions;
import jp.appAdForce.android.ane.functions.AnalyticsManagerFunctions;
import jp.appAdForce.android.ane.functions.LtvManagerFunctions;


public class AppAdForceContext extends FREContext {

	public AppAdForceContext() {
	}

	public Map<String, FREFunction> getFunctions() {
		HashMap<String, FREFunction> result = new HashMap<String, FREFunction>();
		result.put("sendConversion",                      new AdManagerFunctions().new SendConversion());
		result.put("sendConversionWithStartPage",         new AdManagerFunctions().new SendConversionWithStartPage());
		result.put("sendConversionOnconsent",             new AdManagerFunctions().new SendConversionWithStartPage());
		result.put("SendConversionWithBuid",              new AdManagerFunctions().new SendConversionWithBuid());
		result.put("sendConversionForMobage",             new AdManagerFunctions().new SendConversionForMobage());
		result.put("sendUserIdForMobage",                 new AdManagerFunctions().new SendUserIdForMobage());
		result.put("sendReengagementConversion",          new AdManagerFunctions().new SendReengagementConversion());
		result.put("setServerUrl",                        new AdManagerFunctions().new SetServerUrl());
		result.put("setMode",                             new AdManagerFunctions().new SetMode());
		result.put("setMessage",                          new AdManagerFunctions().new SetMessage());
		result.put("setOptout",                           new AdManagerFunctions().new SetOptout());
		result.put("updateFrom2_10_4g",                   new AdManagerFunctions().new UpdateFrom2_10_4g());
		result.put("sendStartSession",                    new AnalyticsManagerFunctions().new SendStartSession());
		result.put("sendEvent",                           new AnalyticsManagerFunctions().new SendEvent());
		result.put("sendEventPurchase",                   new AnalyticsManagerFunctions().new SendEventPurchase());
		result.put("setUserInfo", 		                  new AnalyticsManagerFunctions().new SetUserInfo());
		result.put("getUserInfo", 		                  new AnalyticsManagerFunctions().new GetUserInfo());
		result.put("sendLtv",                             new LtvManagerFunctions().new SendLtv());
		result.put("sendLtvWithAdid",                     new LtvManagerFunctions().new SendLtvWithAdid());
		result.put("addParameter",                        new LtvManagerFunctions().new AddParameter());
		return result;
	}

	@Override
	public void dispose() {
		AdManagerFunctions.dispose();
		LtvManagerFunctions.dispose();
	}
}
