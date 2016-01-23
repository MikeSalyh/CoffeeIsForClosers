package  {
	import flash.display.MovieClip;
	import coffee.GUI.ios.TableView;
	import coffee.GUI.ios.TableNode;
	import flash.events.Event;
	
	public class iOSViewTest extends MovieClip{
		
		var myTable:TableView;
		public function iOSViewTest() {
			// constructor code
			
			//myTable = new TableView();
			//addChild(myTable);
			
			//var myNode:TableNode = new  TableNode("What am I?");
			var myNode:TableNode = new TableNode("redMultiplier:Number (default = 1.0) — The percentage to apply the color, as a decimal value between 0 and 1. greenMultiplier:Number (default = 1.0) — The percentage to apply the color, as a decimal value between 0 and 1. blueMultiplier:Number (default = 1.0) — The percentage to apply the color, as a decimal value between 0 and 1.", pop, true);
			addChild(myNode);
		}
		
		function pop(e:Event):void{
			trace("POP!");
		}

	}
	
}
