package co.cyberz.dahlia
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	public class AdOperation extends EventDispatcher
	{
		private static var context:ExtensionContext = null;
		private var nativeOperation:Object = null;
		
		public function AdOperation(target:IEventDispatcher=null)
		{
			super(target);
			if (!context) {
				context = ExtensionContext.createExtensionContext("jp.appAdForce", null);
			}
			context.addEventListener(StatusEvent.STATUS, operationStateListener);
			nativeOperation = context.call("createAdOperation");
		}
		
		private function operationStateListener(event:StatusEvent):void {
			dispatchEvent(new AdOperationEvent(event.code, event.level));
		}
		
		public function requestAdInfo(placementId:String):void {
			try {
				context.call("requestAdInfo", nativeOperation, placementId);
			} catch(e:Error) {
				traceErr(e);
				throw e;
			}
		}
		
		public static function sendImp(placementId:String, status:Boolean, sessionId:String):void {
			try {
				context.call("sendImp", placementId, status, sessionId);
			} catch(e:Error) {
				traceErr(e);
				throw e;
			}
		}
		
		public static function sendClick(placementId:String, sessionId:String):void {
			try {
				context.call("sendClick", placementId, sessionId);
			} catch(e:Error) {
				traceErr(e);
				throw e;
			}
		}
		
		public static function traceErr(e:Error):void
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