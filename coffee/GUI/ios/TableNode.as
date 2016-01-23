package coffee.GUI.ios {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.Font;
	import coffee.GUI.MuseoSans;
	import flash.events.MouseEvent;
	
	
	public class TableNode extends MovieClip{
		
		private static const HORIZONTAL_PADDING:int = 30, VERTICAL_PADDING:int = 25;
		
		// Text Formats
		private static var simpleFormat:TextFormat; // The standard format for text
		
		
		
		
		private var myBG:TableNodeBG; // The background of the node
		private var _function:Function; // If the node has a function associated with it.
		private var _myCheck:Check; // The checkmark movieclip. Either hidden or visible.
		
		public function TableNode( text:String, actionDelegate:Function = null, isRadioButton:Boolean = false, width:int = 750) {
			
			// First add the text
			var nodeHeight:int = VERTICAL_PADDING; // How tall the node is. It always starts with the top padding.
			nodeHeight += buildText(text, nodeHeight, width); // Build simpletext. Add its height to the node's height.
			nodeHeight += VERTICAL_PADDING; // Add the bottom padding.
			
			// Then, add the background (after we know how tall the text is)
			addBackground( width, nodeHeight);
			
			// Then, hook up the action, if it has one
			if(actionDelegate != null){
				_function = actionDelegate;
				myBG.addEventListener( MouseEvent.MOUSE_UP, getClicked);
				myBG.enabled = true;
				if( isRadioButton){
					addCheckmark(width, nodeHeight);
				} else {
					addArrow(width, nodeHeight);
				}
			}
		}
		
		
		private function getSimpleFormat():TextFormat{
			if( !simpleFormat){
				simpleFormat = new TextFormat();
				simpleFormat.font = "Museo Sans 500";
				simpleFormat.size = 30;
			} 
			return simpleFormat;
		}
		
		private function getBackgroundHeight():int{
			return 0;
		}
		
		// Returns the height of the SimpleText
		private function buildText( text:String, y:int, width:int):Number{
			var myText:TextField = new TextField();
			myText.defaultTextFormat = getSimpleFormat();
			myText.wordWrap = true;
			myText.width = width - HORIZONTAL_PADDING * 4.5;
			myText.x = HORIZONTAL_PADDING;
			myText.y = y;
			myText.antiAliasType = "ADVANCED";
			myText.selectable = false;
			myText.mouseEnabled = false;
			addChild(myText);
			
			myText.text = text;
			var lines:int = myText.numLines;
			var textSize:Number = (myText.defaultTextFormat.size as Number);
			myText.height = lines * (textSize/4 + textSize);
			
			return myText.height;
		}
		
		private function addBackground(nodeWidth:Number, nodeHeight:Number):void{
			myBG = new TableNodeBG(false, nodeWidth, nodeHeight);
			addChild(myBG);
			setChildIndex(myBG, 0);
		}
		
		private function addArrow( nodeWidth:Number, nodeHeight:Number):void{
			var myArrow:Arrow = new Arrow();
			myArrow.x = nodeWidth - HORIZONTAL_PADDING;
			myArrow.y = nodeHeight / 2;
			addChild(myArrow);
		}
		
		private function addCheckmark( nodeWidth:Number, nodeHeight:Number, startVisible:Boolean = false):void{
			_myCheck = new Check();
			_myCheck.x = nodeWidth - HORIZONTAL_PADDING;
			_myCheck.y = nodeHeight / 2;
			addChild(_myCheck);
			_myCheck.visible = startVisible;
		}
		
		public function set checked(value:Boolean):void{
			_myCheck.visible = value;
		}
		
		public function get checked():Boolean{
			return _myCheck.visible;
		}
		
		private function getClicked( e:MouseEvent):void{
			dispatchEvent( new TableEvent( TableEvent.NODE_SELECTED));
			_function(e);
		}
	}
	
}
