package coffee.GUI {
	import flash.display.MovieClip;
	import fl.transitions.Tween;
	import fl.transitions.easing.Regular;
	import flash.events.MouseEvent;
	
	public class TweenManager {	
	
		private static const SMALL_OBJECT:int = 150;
		
		public static function ClickTween( e:MouseEvent):void{
			var scalar:Number;			
			if( (e.target as MovieClip).width < SMALL_OBJECT){
				scalar = 0.8;
			} else {
				scalar = 0.92;
			}
			
			var scaleTweenX = new Tween( e.target, "scaleX", fl.transitions.easing.Regular.easeIn, scalar, 1, 4);
			var scaleTweenY = new Tween( e.target, "scaleY", fl.transitions.easing.Regular.easeIn, scalar, 1, 4);
		}

	}
	
}
