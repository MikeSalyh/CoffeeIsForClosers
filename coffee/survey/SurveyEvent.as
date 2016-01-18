package coffee.GUI {
	import flash.events.Event;
	
	public class SurveyGUIEvent extends Event{

		public static const RECIEVE_INPUT:String = "getInput";
		public static const CLEAR_INPUT:String = "clearInput";
		
		public function SurveyEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}

	}
	
}
