package coffee.GUI {
	
	/*
	TextAnswer
	|
	|-- AnswerField (TextField)
	*/
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.events.TextEvent;
	
	
	public class TextAnswer extends SurveyInput {
		
		
		public function TextAnswer() {
			// constructor code
			super();
			AnswerField.text = "";
			(AnswerField as TextField).addEventListener(Event.CHANGE, sendInputChanged);
		}
		
		
		
		override public function hasInput():Boolean{
			return AnswerField.text.length > 0;
		}
		
		override public function getInput():Object{
			return AnswerField.text;
		}
		
		override public function disableForUnload():void{
			//WIP. 
		}
		
		
	}
	
}
