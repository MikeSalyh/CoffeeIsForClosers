package  {
	import flash.display.MovieClip;
	import coffee.GUI.ios.*;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class iOSViewTest extends MovieClip{
		
		var myTable:TableView, subTable:TableView;
		var myHeader:HeaderBar;
		
		public function iOSViewTest() {
			// constructor code
			myHeader = header;
			myHeader.setHeader("Whatever", "Back and Forth", HeaderBar.SYMBOL_LEFT_ARROW, "", HeaderBar.SYMBOL_PLUS);
		
			
			myTable = new TableView(0, 162, 750, 1070);
			
			/*myTable.addNode( new TableNode("This is the first node", "1.0", "This is a test of notes"));
			myTable.addNode( new TableNode("This is the second node"));
			myTable.addNode( new TableNode("This is the third node"));
			myTable.addNode( new TableNode("This is the first node", "1.0", "This is a test of notes"));
			myTable.addNode( new TableNode("This is the second node"));
			myTable.addNode( new TableNode("This is the third node"));
			myTable.addNode( new ActionNode(pop, "This is the first node", "1.0", "This is a test of notes"));
			myTable.addNode( new TableNode("This is the second node"));
			myTable.addNode( new TableNode("This is the third node"));
			myTable.addNode( new TableNode("This is the first node", "1.0", "This is a test of notes"));
			myTable.addNode( new TableNode("This is the second node"));
			myTable.addNode( new TableNode("This is the third node"));
			myTable.addNode( new TableNode("This is the first node", "1.0", "This is a test of notes"));
			myTable.addNode( new TableNode("This is the second node"));
			myTable.addNode( new TableNode("This is the third node"));
			myTable.addNode( new TableNode("This is the first node", "1.0", "This is a test of notes"));
			myTable.addNode( new TableNode("This is the second node"));
			myTable.addNode( new TableNode("This is the third node"));*/
			
			myTable.addNode( new ActionNode(pop, "Did you lift today?"));
			myTable.addNode( new ActionNode(pop, "What did you have for lunch?"));
			
			holder.addChild(myTable);
			myTable.init();
			
			//var myNode:TableNode = new ActionNode(pop, "Did you lift today?", "Yes", "Father forgive me for these gains I'm about to recieve. Did you lift today? Father forgive me for these gains I'm about to recieve.");
			//var myNode:TableNode = new  TableNode("What am I?", "False", "This is a lame test.");
			//var myNode:TableNode = new CheckNode(pop, "redMultiplier:Number (default = 1.0) — The percentage to apply the color, as a decimal value between 0 and 1. greenMultiplier:Number (default = 1.0) — The percentage to apply the color, as a decimal value between 0 and 1. blueMultiplier:Number (default = 1.0) — The percentage to apply the color, as a decimal value between 0 and 1.", "Yes", "Father forgive me for these gains I'm about to recieve. Did you lift today? Father forgive me for these gains I'm about to recieve.");
			//addChild(myNode);
		}
		
		function pop(e:Event):void{
			trace("POP!");
			myTable.showGreyOverlay();
			
			subTable = new TableView(0, 162, 750, 1070);
			subTable.addNode( new TableNode("Yes", "1/22/2015"));
			subTable.addNode( new TableNode("Yes", "1/23/2015", "It was a bad workout though."));
			subTable.addNode( new TableNode("No", "1/24/2015"));
			subTable.addNode( new TableNode("Yes", "1/25/2015"));
			
			holder.addChild(subTable);
			subTable.init();
			
			
			
			var t:Timer = new Timer(3000, 1);
			t.addEventListener(TimerEvent.TIMER, reset);
			t.start();
		}
		
		function reset(e:TimerEvent):void{
			myTable.hideGreyOverlay();
			subTable.closeAndDestroy();
		}

	}
	
}
