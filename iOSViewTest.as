package  {
	import flash.display.MovieClip;
	import coffee.GUI.ios.*;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class iOSViewTest extends MovieClip{
		
		var myTable:TableView, subTable:TableView;
		var myHeader:HeaderBar;
		var vm:ViewManager;
		
		public function iOSViewTest() {
			// constructor code
			myHeader = header;
			//myHeader.setHeader("Testing...", "Back", HeaderBar.SYMBOL_LEFT_ARROW, "", HeaderBar.SYMBOL_PLUS);
		
			vm = new ViewManager(myHeader, holder);
			myTable = new TableView( "My Questions", 
									new Array(
										new ActionNode(openRandomData, "Did you go to the gym today?"),
										new ActionNode(openRandomData, "What are you even doing with your life?"),
										new ActionNode(openRandomData, "How much wood could a woodchuck chuck?")
										)
									);
			vm.addTableView(myTable);
		}
		
		function pop(e:Event):void{
			trace("POP!");
		}
		
		function openRandomData(e:TableEvent):void{
			var myNodes:Array = new Array();
			myNodes.push( new TableNode("","", e.nodeName));
			var rand:int = Math.random() * 20 + 1;
			for( var i:int = 0; i < rand; i++){
				var answer:String = Math.random() > 0.5 ? "Yes" : "No";
				var dateString:String = "2/" + i + "/2016";
				myNodes.push( new TableNode( answer, dateString));
			}
			
			var t = new TableView( e.nodeName, myNodes);
			vm.addTableView(t);
		}
		

	}
	
}
