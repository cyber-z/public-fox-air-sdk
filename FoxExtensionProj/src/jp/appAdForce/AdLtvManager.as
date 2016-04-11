package jp.appAdForce
{
	import flash.events.EventDispatcher;
	import flash.external.ExtensionContext;
	
	public class AdLtvManager extends EventDispatcher
	{
		public static const PARAM_SKU:String = "_sku";
		public static const PARAM_PRICE:String = "_price";
		public static const PARAM_OUT:String = "_out";
		public static const PARAM_CURRENCY:String = "_currency";

		private var extContext:ExtensionContext = null;

		public function AdLtvManager()
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

		public function sendConversion():void
		{
			trace("Force Operation X extension sendConversion");
			try{
				extContext.call("sendConversion");
			} catch(e:Error){
				traceErr(e);
				throw e;
			}
		}
		
		public function sendConversionWithStartPage(url:String):void
		{
			trace("Force Operation X extension sendConversionWithStartPage" + " url is -> " + url);
			try{
				extContext.call("sendConversionWithStartPage",url);
			} catch(e:Error){
				traceErr(e);
				throw e;
			}
		}

		public function sendConversionWithBuid(url:String, buid:String):void
		{
			trace("Force Operation X extension sendConversionWithBuid" + " url is -> " + url + " buid is -> " + buid);
			try{
				extContext.call("sendConversionWithStartPage",url,buid);
			} catch(e:Error){
				traceErr(e);
				throw e;
			}
		}
		
		public function sendReengagementConversion(urlScheme:String):void
		{
			trace("Force Operation X extension sendReengagementConversion" + " urlScheme is -> " + urlScheme);
			try{
				extContext.call("sendReengagementConversion",urlScheme);	
			} catch(e:Error){
				traceErr(e);
				throw e;
			}
		}
		
		public function sendLtv(cvId:int):void
		{
			trace("Force Operation X extension sendLtv" + " cvId is -> " + cvId);
			try{
				extContext.call("sendLtv",cvId);
			} catch(e:Error){
				traceErr(e);
				throw e;
			}
		}
		
		public function sendLtvWithAdid(cvId:int, adId:String):void
		{
			trace("Force Operation X extension sendLtvWithAdid" + " cvId is -> " + cvId + " adId is -> " + adId);
			try{
				extContext.call("sendLtvWithAdid",cvId,adId);
			} catch(e:Error){
				traceErr(e);
				throw e;
			}
		}
		
		public function addParameter(name:String, val:String):void
		{
			trace("Force Operation X extension addParameter" + " name is -> " + name + " val is -> " + val);
			try{
				extContext.call("addParameter",name,val);
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