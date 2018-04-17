package jp.appAdForce
{
	import flash.events.EventDispatcher;
	import flash.external.ExtensionContext;
	
	public class AnalyticsManager extends EventDispatcher
	{
		private var extContext:ExtensionContext = null;

		private static function nullToEmpty(str:String):String
		{
			if(str == null){
				str = "";
			}
			return str;
		}
		
		public function AnalyticsManager()
		{
			if (!extContext)
			{
				initExtension();
			}
		}
	
		private function initExtension():void
		{
			trace("Force Operation X extension initExtension");
			extContext = ExtensionContext.createExtensionContext("jp.appAdForce", null);
		}

		public function sendStartSession():void
		{
			trace("Force Operation X extension sendStartSession");
			try{
				extContext.call("sendStartSession");
			} catch(e:Error){
				traceErr(e);
				throw e;
			}
		}
		
		public function sendEndSession():void
		{
			trace("Force Operation X extension sendEndSession");
			try{
				extContext.call("sendEndSession");
			} catch(e:Error){
				traceErr(e);
				throw e;
			} 
		}
				
		
		public function sendEvent(eventName:String, action:String, label:String, value:int, event:Object=null):void
		{
			
			eventName = nullToEmpty(eventName);
			action = nullToEmpty(action);
			label = nullToEmpty(label);
			var eventStr:String = "";
			if (event != null) {
				eventStr = nullToEmpty(JSON.stringify(event));
			}
			trace("Force Operation X extension sendEvent" + " eventName is -> " + eventName + " action is -> " + action + " label is -> " + label + " value is -> " + value);
			try{
				extContext.call("sendEvent",eventName,action,label,value, eventStr);
			} catch(e:Error){
				traceErr(e);
				throw e;
			}
		}
		
		
		public function sendEventPurchase(eventName:String, action:String,label:String,orderId:String, sku:String, 
										  itemName:String, price:Number, quantity:int, currency:String, eventInfo:Object=null):void
		{
			
			eventName = nullToEmpty(eventName);
			action = nullToEmpty(action);
			label = nullToEmpty(label);
			orderId = nullToEmpty(orderId);
			sku = nullToEmpty(sku);
			itemName = nullToEmpty(itemName);
			currency = nullToEmpty(currency);
			
			var eventStr:String = "";
			if (eventInfo != null) {
				eventStr = nullToEmpty(JSON.stringify(eventInfo));
			}
			
			trace("Force Operation X extension sendEventPurchase" + " eventName is -> " + eventName + " action is -> " + action + " label is -> " + label + " orderId is -> " + orderId + " sku is -> " + sku + " itemName is -> " + itemName+ " price is -> " + price+ " quantity is -> " + quantity + " currency is -> " + currency);
			try{
				extContext.call("sendEventPurchase",eventName,action,label,orderId,sku,itemName,price,quantity,currency,eventStr);
			} catch(e:Error){
				traceErr(e);
				throw e;
			}
		}
		
		public function getUserInfo():Object {
			var userInfo:Object = null;
			try {
				trace("Force Operation X extension getUserInfo");
				var jsonStr:String = extContext.call("getUserInfo") as String;
				if (jsonStr != null && jsonStr.length > 0) {
					userInfo = JSON.parse(jsonStr);
				}
			} catch(e:Error){
				traceErr(e);
				throw e;
			}
			return userInfo;
		}
		
		public function setUserInfo(json:Object):void {
		
			try {
				trace("Force Operation X extension setUserInfo");
				if (json != null) {
					var jsonStr:String = JSON.stringify(json);
					extContext.call("setUserInfo", nullToEmpty(jsonStr)); 
				}
			} catch(e:Error){
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
			return extContext.dispose();
		}
	}
}