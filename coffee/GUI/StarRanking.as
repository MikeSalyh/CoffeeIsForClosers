package coffee.GUI {
	
	/*
	StarRanking
	|
	|-- Star1 (Mc with 2 frames (1 off, 2 on))
	|-- Star2 (Mc with 2 frames (1 off, 2 on))
	|-- Star3 (Mc with 2 frames (1 off, 2 on))
	|-- Star4 (Mc with 2 frames (1 off, 2 on))
	|-- Star5 (Mc with 2 frames (1 off, 2 on))
	*/
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fl.transitions.Tween;
	import fl.transitions.easing.Regular;
	
	public class StarRanking extends SurveyInput {
		
		private var _myRank:int = 0;
		private var _stars:Array = new Array();
		
		public function StarRanking(startingRank:int = 0) {
			_stars.push(Star1, Star2, Star3, Star4, Star5);
			for( var i:int = 0; i < _stars.length; i++){
				_stars[i].addEventListener( MouseEvent.MOUSE_DOWN, getClicked);
			}
			setRank(startingRank);
		}
		
		override public function hasInput():Boolean{
			return _myRank > 0;
		}
		
		override public function getInput():Object{
			return _myRank;
		}
		
		private function setRank( arg:int):void{
			_myRank = arg;
			for( var i:int = 0; i < _stars.length; i++){
				(_stars[i] as MovieClip).gotoAndStop( arg > i ? 2 : 1);
			}
			sendInputChanged();
		}
		
		private function getClicked( e:MouseEvent):void{
			for( var i:int = 0; i < _stars.length; i++){
				if( e.target == _stars[i]){
					setRank( i + 1);
					return;
				}
			}
		}
		
		override public function disableForUnload():void{
			for( var i:int = 0; i < _stars.length; i++){
				_stars[i].removeEventListener( MouseEvent.MOUSE_DOWN, getClicked);
				_stars[i].mouseEnabled = false;
			}
		}
	}
	
}
