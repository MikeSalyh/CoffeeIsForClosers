package coffee.GUI.ios {
	import flash.events.Event;
	
	public class TableEvent extends Event{

		public static const NODE_SELECTED:String = "node_selected";
		public static const NODE_RELEASED:String = "node_released";
		
		public function TableEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}

	}
	
}
