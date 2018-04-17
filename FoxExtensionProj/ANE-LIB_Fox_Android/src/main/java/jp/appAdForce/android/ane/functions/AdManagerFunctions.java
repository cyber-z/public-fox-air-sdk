package jp.appAdForce.android.ane.functions;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

import jp.appAdForce.android.AdManager;
import jp.appAdForce.android.ane.AppAdForceContext;

public class AdManagerFunctions {

	public static AdManager ad;
	private static final String LOG_TAG = "F.O.X";

	private void init(FREContext context) {
		if (ad == null) ad = new AdManager(((AppAdForceContext) context).getActivity());
	}

	static public void dispose() {
		ad = null;
	}

	public class SendConversion implements FREFunction {
		public FREObject call(FREContext context, FREObject args[]) {
			try {
				init(context);
				ad.sendConversion();
			} catch (Exception e) {
				e.printStackTrace();
				if (e.getCause() != null) e.getCause().printStackTrace();
			}
			return null;
		}
	}
	
	public class SendConversionWithBuid implements FREFunction {
		public FREObject call(FREContext context, FREObject args[]) {
			try {
				init(context);
				String buid;
				if (args.length == 1) {
					buid = args[0].getAsString();
					ad.sendConversionWithBuid(buid);
				} else {
					Log.e(LOG_TAG, "Method not found sendConversionWithBuid args[]:" + args.length);
				}
			} catch (Exception e) {
				e.printStackTrace();
				if (e.getCause() != null) e.getCause().printStackTrace();
			}
			return null;
		}
	}

	public class SendConversionWithStartPage implements FREFunction {
		public FREObject call(FREContext context, FREObject args[]) {
			try {
				init(context);
				String url, buid;
				switch (args.length) {
				case 1:
					url = args[0].getAsString();
					ad.sendConversion(url);
					break;
				case 2:
					url = args[0].getAsString();
					buid = args[1].getAsString();
					ad.sendConversion(url, buid);
					break;
				default:
					Log.e(LOG_TAG, "Method not found sendConversionWithStartPage args[]:" + args.length);
					break;
				}
			} catch (Exception e) {
				e.printStackTrace();
				if (e.getCause() != null) e.getCause().printStackTrace();
			}
			return null;
		}
	}

	/**
	 * for DeNA Mobage
	 */
	public class SendConversionForMobage implements FREFunction {
		public FREObject call(FREContext context, FREObject args[]) {
			try {
				init(context);
				String url, mbgaAppId;
				switch (args.length) {
				case 1:
					mbgaAppId = args[0].getAsString();
					ad.sendConversionForMobage(mbgaAppId);
					break;
				case 2:
					url = args[0].getAsString();
					mbgaAppId = args[1].getAsString();
					ad.sendConversionForMobage(url, mbgaAppId);
					break;
				default:
					Log.e(LOG_TAG, "Method not found sendConversionForMobage args[]:" + args.length);
					break;
				}
			} catch (Exception e) {
				e.printStackTrace();
				if (e.getCause() != null) e.getCause().printStackTrace();
			}
			return null;
		}
	}

	public class SendUserIdForMobage implements FREFunction {
		public FREObject call(FREContext context, FREObject args[]) {
			try {
				init(context);
				String mbgaUserId = args[0].getAsString();
				ad.sendUserIdForMobage(mbgaUserId);
			} catch (Exception e) {
				e.printStackTrace();
				if (e.getCause() != null) e.getCause().printStackTrace();
			}
			return null;
		}
	}

	public class SendReengagementConversion implements FREFunction {
		public FREObject call(FREContext context, FREObject args[]) {
			try {
				init(context);
				String urlScheme = args[0].getAsString();
				ad.sendReengagementConversion(urlScheme);
			} catch (Exception e) {
				e.printStackTrace();
				if (e.getCause() != null) e.getCause().printStackTrace();
			}
			return null;
		}
	}

	public class SetServerUrl implements FREFunction {
		public FREObject call(FREContext context, FREObject args[]) {
			try {
				init(context);
				String serverUrl = args[0].getAsString();
				ad.setServerUrl(serverUrl);
			} catch (Exception e) {
				e.printStackTrace();
				if (e.getCause() != null) e.getCause().printStackTrace();
			}
			return null;
		}
	}

	public class SetMode implements FREFunction {
		public FREObject call(FREContext context, FREObject args[]) {
			return null;
		}
	}
	
	public class SetMessage implements FREFunction {
		public FREObject call(FREContext context, FREObject args[]) {
			return null;
		}
	}
	
	public class SetOptout implements FREFunction {
		public FREObject call(FREContext context, FREObject args[]) {
			try {
				init(context);
				boolean optout = args[0].getAsBool();
				ad.setOptout(optout);
			} catch (Exception e) {
				e.printStackTrace();
				if (e.getCause() != null) e.getCause().printStackTrace();
			}
			return null;
		}
	}
	
	public class UpdateFrom2_10_4g implements FREFunction {
		public FREObject call(FREContext context, FREObject args[]) {
			try {
				AdManager.updateFrom2_10_4g();
			} catch (Exception e) {
				e.printStackTrace();
				if (e.getCause() != null) e.getCause().printStackTrace();
			}
			return null;
		}
	}
}
