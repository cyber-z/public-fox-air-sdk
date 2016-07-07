package co.cyberz.dahlia
{
	import flash.events.Event;
	
	public class AdOperationEvent extends Event
	{
		public static const AD_SUCCESS:String = "SUCCESS";
		public static const AD_FAILED:String = "FAILED";
		
		public var data:Object = null;
		
		public function AdOperationEvent(type:String, data:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			if (data != null && data.length > 0) {
				this.data = JSON.parse(data);
			}
		}
	}
}