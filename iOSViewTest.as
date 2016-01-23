package  {
	import flash.display.MovieClip;
	import coffee.GUI.ios.*;
	import flash.events.Event;
	
	public class iOSViewTest extends MovieClip{
		
		var myTable:TableView;
		public function iOSViewTest() {
			// constructor code
			
			//myTable = new TableView();
			//addChild(myTable);
			
			//var myNode:TableNode = new ActionNode(pop, "Did you lift today?", "Yes", "Father forgive me for these gains I'm about to recieve. Did you lift today? Father forgive me for these gains I'm about to recieve.");
			var myNode:TableNode = new  TableNode("What am I?", "False", "This is a lame test.");
			//var myNode:TableNode = new CheckNode(pop, "redMultiplier:Number (default = 1.0) — The percentage to apply the color, as a decimal value between 0 and 1. greenMultiplier:Number (default = 1.0) — The percentage to apply the color, as a decimal value between 0 and 1. blueMultiplier:Number (default = 1.0) — The percentage to apply the color, as a decimal value between 0 and 1.", "Yes", "Father forgive me for these gains I'm about to recieve. Did you lift today? Father forgive me for these gains I'm about to recieve.");
			addChild(myNode);
		}
		
		function pop(e:Event):void{
			trace("POP!");
		}

	}
	
}
