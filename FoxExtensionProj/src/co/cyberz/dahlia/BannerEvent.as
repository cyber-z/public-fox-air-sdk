package co.cyberz.dahlia
{
	import flash.events.Event;
	
	public class BannerEvent extends Event
	{
		public static const AD_SUCCESS:String = "SUCCESS";
		public static const AD_FAILED:String = "FAILED";
		
		public function BannerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}