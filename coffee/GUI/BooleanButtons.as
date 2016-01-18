package coffee.GUI {
	
	/*
	BooleanButtons
	|
	|-- TrueBtn (Movieclip, two frames: 1-off, 2-on)
	|-- FalseBtn (Movieclip, two frames: 1-off, 2-on)
	*/
	
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	public class BooleanButtons extends SurveyInput{
		public function BooleanButtons(startTrue:Boolean = false) {
			super();
			
			// constructor code
			TrueBtn.stop();
			FalseBtn.stop();
			
			TrueBtn.addEventListener(MouseEvent.MOUSE_DOWN, pressBtn);
			FalseBtn.addEventListener(MouseEvent.MOUSE_DOWN, pressBtn);
			
			
			
			// If startTrue, the buttons start with the true button pre-pressed.
			// Otherwise, neither button begins selected.
			if( startTrue){
				pressTrue();
			}
		}
		
		private function pressBtn( e:MouseEvent):void{
			if( e.target == TrueBtn){
				pressTrue();
			} else if( e.target == FalseBtn){
				pressFalse();
			}
		}
		
		private function pressTrue():void{
			TrueBtn.gotoAndStop(2);
			FalseBtn.gotoAndStop(1);
			sendInputChanged();
		}
		
		private function pressFalse():void{
			TrueBtn.gotoAndStop(1);
			FalseBtn.gotoAndStop(2);
			sendInputChanged();
		}
				
		// Check whether or not either button is pressed.
		override public function hasInput():Boolean{
			return( TrueBtn.currentFrame == 2 || FalseBtn.currentFrame == 2);
		}
		
		override public function getInput():Object{
			if( TrueBtn.currentFrame == 2){
				return true;
			} else if( FalseBtn.currentFrame == 2){
				return false;
			} else {
				throw new Error("No input to get.");
			}
		}
		
		override public function disableForUnload():void{
			TrueBtn.removeEventListener(MouseEvent.MOUSE_DOWN, pressBtn);
			FalseBtn.removeEventListener(MouseEvent.MOUSE_DOWN, pressBtn);
			TrueBtn.mouseEnabled = false;
			FalseBtn.mouseEnabled = false;
		}
		
		
		
	}
	
}
