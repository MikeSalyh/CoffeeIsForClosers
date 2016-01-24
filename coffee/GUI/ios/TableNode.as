package coffee.GUI.ios {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.Font;
	import coffee.GUI.MuseoSans;
	import flash.events.MouseEvent;
	
	
	public class TableNode extends MovieClip{
		
		protected static const HORIZONTAL_PADDING:int = 30, VERTICAL_PADDING:int = 25, MIN_HEIGHT:int = 85;
				
		protected var myBG:TableNodeBG; // The background of the node
		
		public function TableNode(text:String="", data:String="", subtitle:String="", width:int = 750) {
			
			// First add the text
			var nodeHeightLeft:int = VERTICAL_PADDING; // How tall the node is. It always starts with the top padding.
			var nodeHeightRight:int = VERTICAL_PADDING;
			
			if( text.length){
				nodeHeightLeft += addText(text, nodeHeightLeft, (subtitle.length ? width*0.75 : width), TableNodeFormat.SIMPLE); // Build simpletext. Add its height to the node's height.
			}
			if( subtitle.length){
				nodeHeightLeft += addText(subtitle, nodeHeightLeft + 10, width, TableNodeFormat.SUBTITLE);
			}
			
			if( data.length){
				nodeHeightRight += addText(data, nodeHeightRight, width, TableNodeFormat.DATA);
			}
			
			nodeHeightLeft += VERTICAL_PADDING; // Add the bottom padding.
			nodeHeightRight += VERTICAL_PADDING;
			
			var totalHeight:int = (nodeHeightLeft > nodeHeightRight ? nodeHeightLeft : nodeHeightRight);
			if(totalHeight < MIN_HEIGHT)
				totalHeight = MIN_HEIGHT;
			
			// Then, add the background (after we know how tall the text is)
			addBackground( width, totalHeight);
			
			myBG.addEventListener( MouseEvent.MOUSE_DOWN, getPressed);
		}
		
		private function addText(text:String, y:int, width:int, format:TextFormat, x:int = 0):Number{
			var myText:TextField = new TextField();
			myText.defaultTextFormat = format;
			myText.wordWrap = true;
			myText.width = width - HORIZONTAL_PADDING * 4.5;
			myText.x = HORIZONTAL_PADDING + x;
			myText.y = y;
			myText.antiAliasType = "ADVANCED";
			myText.selectable = false;
			myText.mouseEnabled = false;
			addChild(myText);
			
			myText.text = text;
			var lines:int = myText.numLines;
			var textSize:Number = (myText.defaultTextFormat.size as Number);
			var textLeading:Number = (myText.defaultTextFormat.leading as Number);
			myText.height = lines * (textSize/3.3 + textSize);
			
			return myText.height;
		}
		
		
		private function addBackground(nodeWidth:Number, nodeHeight:Number):void{
			myBG = new TableNodeBG(false, nodeWidth, nodeHeight);
			addChild(myBG);
			setChildIndex(myBG, 0);
		}
		
		private function getPressed( e:MouseEvent):void{
			dispatchEvent( new TableEvent( TableEvent.NODE_TAPPED));
		}
	}
	
}
