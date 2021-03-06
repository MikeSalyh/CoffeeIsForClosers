﻿package coffee.GUI.ios {
	import flash.events.MouseEvent;
	
	public class ActionNode extends TableNode{

		protected var _function:Function; // If the node has a function associated with it.
		protected static var _enabled = true;

		public static function set enabled(value:Boolean):void{
			_enabled = value;
		}

		public static function get enabled():Boolean{
			return _enabled;
		}

		public function ActionNode(delegate:Function=null, text:String="", data:String="", subtitle:String="", width:int = 750) {
			// constructor code
			super(text, data, subtitle, width);
			
			_function = delegate;
			myBG.addEventListener( MouseEvent.MOUSE_UP, getClicked);
			myBG.enabled = true;
			addActionSymbol(width, height);
		}
		
		protected function addActionSymbol( nodeWidth:Number, nodeHeight:Number):void{
			var myArrow:Arrow = new Arrow();
			myArrow.x = nodeWidth - HORIZONTAL_PADDING;
			myArrow.y = nodeHeight / 2;
			addChild(myArrow);
		}
		
		private function getClicked( e:MouseEvent):void{
			if(_enabled){
				var te:TableEvent = new TableEvent( TableEvent.NODE_ACTIVATED, nodeName)
				dispatchEvent( te);
				_function(te);
			}
		}
	}
	
}
