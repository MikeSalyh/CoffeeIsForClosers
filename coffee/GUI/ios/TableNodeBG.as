package coffee.GUI.ios {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import fl.motion.Color;
	import flash.events.Event;
	import flash.display.SimpleButton;
	
	/*
	| TableNodeBG
	|
	|-- BG (simplebutton)
	|-- Border (movieclip)
	*/
	
	// This class exists so that the divider line on the node BG never stretches, no matter the height of the object.
	// It also controls whether or not the button changes colors when tapped on.
	
	public class TableNodeBG extends MovieClip {
		
		public function TableNodeBG(enabled:Boolean = false, width:Number = 750, height:Number = 85) {
			this.height = height;
			this.width = width;
			this.enabled = enabled;
		}
		
		override public function set height(value:Number):void{
			(BG as SimpleButton).height = value;
			(Border as MovieClip).y = value;
		}
		
		override public function set enabled(value:Boolean):void{
			super.enabled = value;
			(BG as SimpleButton).enabled = value; //disable the interactive colors too.
		}
		
	}
	
}
