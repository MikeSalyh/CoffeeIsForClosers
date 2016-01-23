package coffee.GUI.ios {
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	public class CheckNode extends ActionNode{

		private var _myCheck:MovieClip;

		public function CheckNode(delegate:Function=null, text:String="", data:String="", subtitle:String="", width:int = 750) {
			// constructor code
			super(delegate, text, data, subtitle, width);
		}
		
		override protected function addActionSymbol( nodeWidth:Number, nodeHeight:Number):void{
			_myCheck = new Check();
			_myCheck.x = nodeWidth - HORIZONTAL_PADDING;
			_myCheck.y = nodeHeight / 2;
			addChild(_myCheck);
			
			checked = false;
		}
		
		public function set checked(value:Boolean):void{
			_myCheck.visible = value;
		}
		
		public function get checked():Boolean{
			return _myCheck.visible;
		}

	}
	
}
