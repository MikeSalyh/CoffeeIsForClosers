package coffee.GUI.ios {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class ViewManager {

		private var viewList:Vector.<TableView>;
		
		private var header:HeaderBar;
		private var viewParent:MovieClip;
		
		public function ViewManager(headerBar:HeaderBar, viewParent:MovieClip) {
			// constructor code
			this.header = headerBar;
			header.addEventListener( HeaderEvent.LEFT_TAPPED, goBack);
			
			this.viewParent = viewParent;
			viewList = new Vector.<TableView>();
		}
		
		public function addTableView(tableView:TableView):void{
			if(viewList.length >= 1){
				var topTable:TableView = viewList[viewList.length - 1];
				topTable.showGreyOverlay();
				header.showBackButton(); //topTable.name);
			}
			
			viewList.push(tableView);
			viewParent.addChild(tableView);
			tableView.init(true);
			header.setTitle(tableView.name);
		}
		
		private function goBack(e:Event = null):void{
			if( viewList.length >= 2){
				// If there's room to go back
				viewList.pop().closeAndDestroy();
				viewList[viewList.length -1].hideGreyOverlay();
				header.setTitle(viewList[viewList.length -1].name);
			}
			if( viewList.length < 2){
				header.hideBackButton();
			}
		}

	}
	
}
