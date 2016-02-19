package coffee.GUI.ios {
	import flash.display.MovieClip;
	
	public class HeaderData {

		public function HeaderData(name:String, leftText:String = "", useLeftIcon:Boolean = false, leftDelegate:Function = null, rightText:String = "", useRightIcon:Boolean = false, rightDelegate:Function = null) {
			// constructor code
			this._name = name;
			this.leftText = leftText;
			this.useLeftIcon = useLeftIcon;
			this.leftDelegate = leftDelegate;
			this.rightText = rightText;
			this.useRightIcon = useRightIcon;
			this.rightDelegate = rightDelegate;
		}
		
		private var _name:String;
		public function get name():String{
			return _name;
		}
		
		public function set name(value:String):void{
			_name = value;
		}
		
		public var leftText:String;
		public var rightText:String;
		
		public var useLeftIcon:Boolean = false;
		public var useRightIcon:Boolean = false;
		
		public var leftDelegate:Function;
		public var rightDelegate:Function;

	}
	
}
