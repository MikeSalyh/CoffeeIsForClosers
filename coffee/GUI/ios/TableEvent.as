package coffee.GUI.ios {
	import flash.events.Event;
	
	public class TableEvent extends Event{

		public static const NODE_TAPPED:String = "node_tapped";
		public static const NODE_ACTIVATED:String = "node_activated";
		
		private var _nodeName:String;
		
		public function TableEvent(type:String, nodeName:String, bubbles:Boolean = true, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			this._nodeName = nodeName;
		}
		
		public function get nodeName():String{
			return _nodeName;
		}
		

	}
	
}
