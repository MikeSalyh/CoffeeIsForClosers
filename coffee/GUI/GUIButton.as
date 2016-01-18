package coffee.GUI {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class GUIButton extends MovieClip{

		public function GUIButton() {
			// constructor code
			addEventListener( MouseEvent.MOUSE_DOWN, TweenManager.ClickTween);
			buttonMode = true;
		}

	}
	
}
