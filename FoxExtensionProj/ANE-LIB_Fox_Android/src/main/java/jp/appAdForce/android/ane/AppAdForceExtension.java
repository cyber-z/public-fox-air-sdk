package jp.appAdForce.android.ane;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

public class AppAdForceExtension implements FREExtension {

	public AppAdForceExtension() {
	}

	public FREContext createContext(String arg) {
		return new AppAdForceContext();
	}

	public void initialize() {
	}

	public void dispose() {
	}
}
