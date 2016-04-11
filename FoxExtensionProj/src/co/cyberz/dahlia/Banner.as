package co.cyberz.dahlia
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;

	public class Banner extends EventDispatcher
	{
		public static const POSITION_TOP:int = 1;
		public static const POSITION_BOTTOM:int = 2;
		public static const POSITION_TOP_LEFT:int = 3;
		public static const POSITION_TOP_RIGHT:int = 4;
		public static const POSITION_BOTTOM_LEFT:int = 5;
		public static const POSITION_BOTTOM_RIGHT:int = 6;

		private var context:ExtensionContext = null;
		private var bannerImp:Object = null;

		public function Banner()
		{
			if (!context) {
				context = ExtensionContext.createExtensionContext("jp.appAdForce", null);
			}
			context.addEventListener(StatusEvent.STATUS, bannerStateListener);
			bannerImp = context.call("createBannerView");
		}

		public function show(placementId:String, position:int):void {
			try {
				if (context) {
					context.call("showBanner", bannerImp, placementId, position);
				}
			} catch(e:Error) {
				traceErr(e);
				throw e;
			}
		}

		private function bannerStateListener(event:StatusEvent):void {
			dispatchEvent(new BannerEvent(event.code));
		}

		public function hide():void {
			try {
				if (context) {
					context.call("hideBanner", bannerImp);
				}
			} catch(e:Error) {
				traceErr(e);
				throw e;
			}
		}


		public function traceErr(e:Error):void
		{
			if (e == null) return;
			trace("Error:\nerrorID:" + e.errorID + "\nerrorName:" + e.name + "\nerrorMSG:" + e.message + "\n" + e.getStackTrace());
		}

		public function dispose():void
		{
			if(context) context.dispose();
		}

	}
}
