package coffee.GUI.ios {
	import flash.events.Event;
	
	public class HeaderEvent extends Event{

		public static const LEFT_TAPPED:String = "leftTapped";
		public static const RIGHT_TAPPED:String = "rightTapped";
		
		public function HeaderEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}

	}
	
}
