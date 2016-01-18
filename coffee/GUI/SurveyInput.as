package  coffee.GUI{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class SurveyInput extends MovieClip{

		public function hasInput():Boolean{
			return false;
			// The subclasses will be capable of having input.
		}
		
		
		// Whenever the input changes, dispatch an event.
		public function sendInputChanged(e:Event = null):void{
			if( hasInput()){
				this.dispatchEvent( new SurveyGUIEvent(SurveyGUIEvent.RECIEVE_INPUT));
			} else {
				this.dispatchEvent( new SurveyGUIEvent(SurveyGUIEvent.CLEAR_INPUT));
			}
		}
		
		 public function getInput():Object{
			 return null;
		 }
		 
		 public function disableForUnload():void{
		 }
	}
	
}
