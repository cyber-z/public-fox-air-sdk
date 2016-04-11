package co.cyberz.dahlia
{
	import flash.events.Event;
	
	public class InterstitialEvent extends Event
	{
		public static const AD_SUCCESS:String = "SUCCESS";
		public static const AD_FAILED:String = "FAILED";
		public static const AD_CLOSED:String = "CLOSED";
		
		public function InterstitialEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}