package jp.appAdForce.android.ane.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

import jp.appAdForce.android.AdManager;
import jp.appAdForce.android.LtvManager;
import jp.appAdForce.android.ane.AppAdForceContext;

import static jp.appAdForce.android.ane.functions.AdManagerFunctions.ad;

public class LtvManagerFunctions {

	public static LtvManager ltv;

	private void init(FREContext context) {
		if (ad == null) ad = new AdManager(((AppAdForceContext) context).getActivity());
		if (ltv == null) ltv = new LtvManager(ad);
	}

	static public void dispose() {
		ad = null;
		ltv = null;
	}

	private void sendLtv(FREContext context, int cvPoint, String buId) {
		init(context);
		if (buId == null) {
			ltv.sendLtvConversion(cvPoint);
		} else {
			ltv.sendLtvConversion(cvPoint, buId);
		}
		ltv.clearParam();
	}

	public class SendLtv implements FREFunction {
		public FREObject call(FREContext context, FREObject args[]) {
			try {
				int cvPoint = args[0].getAsInt();
				sendLtv(context, cvPoint, null);
			} catch (Exception e) {
				e.printStackTrace();
				if (e.getCause() != null) e.getCause().printStackTrace();
			}
			return null;
		}
	}

	public class SendLtvWithAdid implements FREFunction {
		public FREObject call(FREContext context, FREObject args[]) {
			try {
				int cvPoint = args[0].getAsInt();
				String buid = args[1].getAsString();
				sendLtv(context, cvPoint, buid);
			} catch (Exception e) {
				e.printStackTrace();
				if (e.getCause() != null) e.getCause().printStackTrace();
			}
			return null;
		}
	}

	public class AddParameter implements FREFunction {
		public FREObject call(FREContext context, FREObject args[]) {
			try {
				init(context);
				String name = args[0].getAsString();
				String val = args[1].getAsString();
				ltv.addParam(name, val);
			} catch (Exception e) {
				e.printStackTrace();
				if (e.getCause() != null) e.getCause().printStackTrace();
			}
			return null;
		}
	}
}
