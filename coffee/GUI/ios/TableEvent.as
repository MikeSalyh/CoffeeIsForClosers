package coffee.GUI.ios {
	import flash.events.Event;
	
	public class TableEvent extends Event{

		public static const NODE_TAPPED:String = "node_tapped";
		public static const NODE_ACTIVATED:String = "node_activated";
		
		public function TableEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}

	}
	
}
