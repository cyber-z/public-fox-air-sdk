package co.cyberz.dahlia
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.system.Capabilities;

	public class Interstitial extends EventDispatcher
	{
		private var context:ExtensionContext = null;
		private var interstitialImp:Object = null;

		public function Interstitial()
		{
			if (!context) {
				context = ExtensionContext.createExtensionContext("jp.appAdForce", null);
				context.addEventListener(StatusEvent.STATUS, interstitialStateListener);
			}
			if (Capabilities.version.toUpperCase().indexOf("IOS") != -1) {
				interstitialImp = context.call("createInterstitial");
			}
		}

		public function show(placementId:String):void {
			try {
				context.call("showInterstitial", interstitialImp, placementId);
			} catch(e:Error) {
				traceErr(e);
				throw e;
			}
		}

		private function interstitialStateListener(event:StatusEvent):void {
			dispatchEvent(new InterstitialEvent(event.code));
		}

		public function traceErr(e:Error):void
		{
			if (e == null) return;
			trace("Error:\nerrorID:" + e.errorID + "\nerrorName:" + e.name + "\nerrorMSG:" + e.message + "\n" + e.getStackTrace());
		}

		public function dispose():void
		{
			return context.dispose();
		}

	}
}
