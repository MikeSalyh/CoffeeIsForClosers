package coffee.GUI {
	
	/*
	DoneButton
	|
	|-- InnerCircle (MovieClip)
	*/
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import fl.transitions.Tween;
	import fl.transitions.easing.Bounce;
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	import fl.transitions.TweenEvent;
	
	
	public class DoneButton extends GUIButton {
		
		
		private var scaleTweenX:Tween, scaleTweenY:Tween;
		
		public function DoneButton( startHidden:Boolean = true) {
			// constructor code
			if( startHidden){
				visible = false;
			}
		}
		
		public function show(e:Event = null):void{
			if(visible)
				return;
				
			visible = true;
			scaleTweenX = new Tween( this, "scaleX", fl.transitions.easing.Elastic.easeOut, 0.3, 1, 0.4, true);
			scaleTweenY = new Tween( this, "scaleY", fl.transitions.easing.Elastic.easeOut, 0.3, 1, 0.4, true);
		}
		
		public function hide( e:Event = null):void{
			visible = false;
		}
		
		public function close(e:Event = null):void{
			scaleTweenX = new Tween( this, "scaleX", fl.transitions.easing.Regular.easeIn, 1, 0.3, 0.2, true);
			scaleTweenY = new Tween( this, "scaleY", fl.transitions.easing.Regular.easeIn, 1, 0.3, 0.2, true);
			scaleTweenX.addEventListener(TweenEvent.MOTION_FINISH, hide);
		}
		
	}
	
}
