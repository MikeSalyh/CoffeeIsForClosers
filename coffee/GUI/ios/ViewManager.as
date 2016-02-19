package coffee.GUI.ios {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class ViewManager {

		private var viewList:Vector.<TableView>;
		
		private var header:HeaderBar;
		private var viewParent:MovieClip;
		
		// The back command; used by multiple tables.
		private static const DEFAULT_LEFT_TEXT:String = "Back";
		private static const DEFAULT_LEFT_ICON:Boolean = true;


		public function ViewManager(headerBar:HeaderBar, viewParent:MovieClip) {
			// constructor code
			this.header = headerBar;			
			this.viewParent = viewParent;
			viewList = new Vector.<TableView>();
		}
		
		public function addTableView(tableView:TableView, useCustomActions:Boolean = false):void{
			if(viewList.length >= 1){
				currentTable.showGreyOverlay();
			}
			
			viewList.push(tableView);
			viewParent.addChild(tableView);
			tableView.init(true);
			
			header.setTitle(currentTable.headerData.name);
			if(!useCustomActions){
				if(viewList.length > 1){
					currentTable.headerData.leftText = DEFAULT_LEFT_TEXT;
					currentTable.headerData.useLeftIcon = DEFAULT_LEFT_ICON;
					currentTable.headerData.leftDelegate = GO_BACK;
				} else {
					currentTable.headerData.leftText = "";
					currentTable.headerData.useLeftIcon = false;
					currentTable.headerData.leftDelegate = null;
				}
			}
			header.setLeftAction(currentTable.headerData);
		}
		
		private function GO_BACK(e:Event = null):void{
			if( viewList.length >= 2){
				// If there's room to go back
				viewList.pop().closeAndDestroy();
				currentTable.hideGreyOverlay();
				header.setTitle(currentTable.headerData.name);
			}
			
			header.setLeftAction(currentTable.headerData);
		}
		
		private function get currentTable():TableView{
			return viewList[viewList.length -1];
		}

	}
	
}
