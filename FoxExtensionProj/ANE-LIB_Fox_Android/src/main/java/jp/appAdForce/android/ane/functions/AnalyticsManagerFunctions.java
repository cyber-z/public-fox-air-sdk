package jp.appAdForce.android.ane.functions;

import android.app.Activity;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

import org.json.JSONObject;

import jp.appAdForce.android.AnalyticsManager;
import jp.appAdForce.android.ane.AppAdForceContext;

public class AnalyticsManagerFunctions {

	public class SendStartSession implements FREFunction {
		public FREObject call(FREContext context, FREObject args[]) {
			try {
				AnalyticsManager.sendStartSession(((AppAdForceContext) context).getActivity());
			} catch (Exception e) {
				e.printStackTrace();
				if (e.getCause() != null)
					e.getCause().printStackTrace();
			}
			return null;
		}
	}
	
	public class SendEvent implements FREFunction {
		public FREObject call(FREContext context, FREObject args[]) {
			try {
				Activity activity = ((AppAdForceContext) context).getActivity();
				String eventName = args[0].getAsString();
				String action = args[1].getAsString();
				String label = args[2].getAsString();
				int value = args[3].getAsInt();
				try {
					String jsonStr = args[4].getAsString();
					if (jsonStr != null && 0 < jsonStr.length()) {
						JSONObject eventInfo = new JSONObject(jsonStr);
						AnalyticsManager
								.sendEvent(activity,
										eventName,
										action,
										label,
										value,
										eventInfo);
						return null;
					}
				} catch (Exception e) {
				}
				AnalyticsManager.sendEvent(activity, eventName, action, label, value);
			} catch (Exception e) {
				e.printStackTrace();
				if (e.getCause() != null)
					e.getCause().printStackTrace();
			}
			return null;
		}
	}
	
	
	public class SendEventPurchase implements FREFunction {
		public FREObject call(FREContext context, FREObject args[]) {
			try {
				Activity activity = ((AppAdForceContext) context).getActivity();
				String eventName = args[0].getAsString();
				String action = args[1].getAsString();
				String label = args[2].getAsString();
				String orderId = args[3].getAsString();
				String sku = args[4].getAsString();
				String itemName = args[5].getAsString();
				double price = args[6].getAsDouble();
				int quantity = args[7].getAsInt();
				String currency = args[8].getAsString();
				try {
					String jsonStr = args[9].getAsString();
					if (jsonStr != null && 0 < jsonStr.length()) {
						JSONObject eventInfo = new JSONObject(jsonStr);
						AnalyticsManager
								.sendEvent(activity,
										   eventName,
										   action,
										   label,
										   orderId,
										   sku,
										   itemName,
										   price,
										   quantity,
										   currency,
										   eventInfo);
						return null;
					}
				} catch (Exception e) {
				}
				AnalyticsManager
						.sendEvent(activity,
								eventName,
								action,
								label,
								orderId,
								sku,
								itemName,
								price,
								quantity,
								currency);
			} catch (Exception e) {
				e.printStackTrace();
				if (e.getCause() != null)
					e.getCause().printStackTrace();
			}
			return null;
		}
	}

	public class SetUserInfo implements FREFunction {
		public FREObject call(FREContext context, FREObject args[]) {
			try {
				Activity activity = ((AppAdForceContext) context).getActivity();
				String jsonStr = args[0].getAsString();
				if (jsonStr != null && 0 < jsonStr.length()) {
					JSONObject userInfo = new JSONObject(jsonStr);
					AnalyticsManager.setUserInfo(activity, userInfo);
				}
			} catch (Exception e) {
				e.printStackTrace();
				if (e.getCause() != null)
					e.getCause().printStackTrace();
			}
			return null;
		}
	}

	public class GetUserInfo implements FREFunction {
		public FREObject call(FREContext context, FREObject args[]) {
			FREObject freObject = null;
			try {
				Activity activity = ((AppAdForceContext) context).getActivity();
				if (activity == null) return freObject;
				JSONObject userInfo = AnalyticsManager.getUserInfo(activity);
				if (userInfo == null) return freObject;
				freObject = FREObject.newObject(userInfo.toString());
			} catch (Exception e) {
				e.printStackTrace();
				if (e.getCause() != null)
					e.getCause().printStackTrace();
			}
			return freObject;
		}
	}
	
}
