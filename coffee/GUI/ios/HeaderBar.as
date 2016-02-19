package coffee.GUI.ios {
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	
	public class HeaderBar extends MovieClip {
		
		public static const SYMBOL_LEFT_ARROW:String = "leftArrow";
		public static const SYMBOL_PLUS:String = "plus";
		public static const SYMBOL_NONE:String = "NONE";
		
		
		private const HEIGHT:int = 90;
		private var fullWidth:int;		
		private var leftHalfBtn:MovieClip, rightHalfBtn:MovieClip;
		
		// The function that's executed when the left button is clicked.
		private var leftDelegate:Function;
		
		// The icon symbols
		private var leftSymbolMC:MovieClip, rightSymbolMC:MovieClip;
		
		// The textfields
		private var leftTextField:TextField, headerTextField:TextField, rightTextField:TextField;

		
		public function HeaderBar(width:int = 750) {
			// constructor code
			fullWidth = width;
			
			leftHalfBtn = createHalfBox(-fullWidth/2, -HEIGHT/4);
			addChild(leftHalfBtn);
			
			rightHalfBtn = createHalfBox(0, -HEIGHT/4);
			addChild(rightHalfBtn);
			
			trace(rightHalfBtn.x);
		}
		
		private function createHalfBox(x:int = 0, y:int = 0):MovieClip{
			var out:MovieClip = new MovieClip();
			out.x = x;
			out.y = y;
			
			var invis_box:Shape = new Shape();
			out.addChild(invis_box);
			invis_box.graphics.beginFill(0x000000, 0);
			invis_box.graphics.lineTo(0, 0);
			invis_box.graphics.lineTo(0, HEIGHT);
			invis_box.graphics.lineTo(fullWidth/2, HEIGHT);
			invis_box.graphics.lineTo(fullWidth/2, 0);
			invis_box.graphics.lineTo(0, 0);
			invis_box.graphics.endFill();
			return out;
		}
		
		public function setLeftAction( data:HeaderData):void{	
			if( data.leftDelegate != null){
				this.leftDelegate = data.leftDelegate;
				leftHalfBtn.addEventListener(MouseEvent.MOUSE_DOWN, handleLeftTapped);
				leftHalfBtn.buttonMode = true;
			} else {
				leftHalfBtn.removeEventListener(MouseEvent.MOUSE_DOWN, handleLeftTapped);
				leftHalfBtn.buttonMode = false;
			}
			
			const PADDING:int = 10;
			var leftEdge = -fullWidth/2 + PADDING;

			// First, add the arrow
			if(leftSymbolMC == null){
				leftSymbolMC = new ArrowLeft();
				leftSymbolMC.x = leftEdge;
				leftSymbolMC.y = HEIGHT/4;
				leftSymbolMC.mouseEnabled = false;
				addChild(leftSymbolMC);
			}
			leftSymbolMC.visible = data.useLeftIcon;
			leftEdge += leftSymbolMC.width + PADDING;
			
			// Then, add the text
			if(leftTextField == null){
				leftTextField = new TextField();
				addChild(leftTextField);
				leftTextField.x = leftEdge;
				leftTextField.defaultTextFormat = HeaderFormat.HEADER_ACTION_LEFT;
				leftTextField.autoSize = TextFieldAutoSize.LEFT;
				
				leftTextField.antiAliasType = "ADVANCED";
				leftTextField.selectable = false;
				leftTextField.mouseEnabled = false;
			} else {
				leftTextField.visible = true;
			}
			leftTextField.text = data.leftText;
			leftEdge += leftTextField.width + PADDING;
			leftHalfBtn.width = Math.abs(-fullWidth/2 - leftEdge);
		}
		
		public function setTitle( value:String):void{
			// Then the center text
			if( headerTextField == null){
				headerTextField = new TextField();
				addChild(headerTextField);
				headerTextField.antiAliasType = "ADVANCED";
				headerTextField.defaultTextFormat = HeaderFormat.HEADER_CENTER;
				headerTextField.selectable = false;
				headerTextField.mouseEnabled = false;
				headerTextField.width = 500;
				headerTextField.x = -fullWidth/2 + 125;
				headerTextField.wordWrap = true;
			}
			
			// Add the text, then truncate it.
			headerTextField.text = value;
			while ( headerTextField.numLines > 1 ) 
   				 headerTextField.text = headerTextField.text.slice(0, -4) + "...";
		}
		
		
		/*
		public function setHeader(headerString:String, leftString:String = "", leftSymbol:String = "NONE", rightString:String = "", rightSymbol:String = "NONE"){
			
			// Turn on/off buttons, depending on if they're being used.
			if(leftString.length > 0 || leftSymbol != SYMBOL_NONE){
				leftHalfBtn.addEventListener(MouseEvent.MOUSE_DOWN, handleLeftTapped);
				leftHalfBtn.buttonMode = true;
			} else {
				leftHalfBtn.removeEventListener(MouseEvent.MOUSE_DOWN, handleLeftTapped);
				leftHalfBtn.buttonMode = false;
			}
			
			if(rightString.length > 0  || leftSymbol != SYMBOL_NONE){
				rightHalfBtn.addEventListener(MouseEvent.MOUSE_DOWN, handleRightTapped);
				rightHalfBtn.buttonMode = true;
			} else {
				rightHalfBtn.removeEventListener(MouseEvent.MOUSE_DOWN, handleRightTapped);
				rightHalfBtn.buttonMode = false;
			}
			
			// Build from the left to the right:
			const PADDING:int = 10;
			
			// Start with the left symbol.
			var leftEdge = -fullWidth/2 + PADDING;
			if(leftSymbol != HeaderBar.SYMBOL_NONE){
				leftSymbolMC = leftSymbol == HeaderBar.SYMBOL_PLUS ? new Plus() : new ArrowLeft();
				leftSymbolMC.x = leftEdge;
				leftSymbolMC.y = HEIGHT/4;
				leftSymbolMC.mouseEnabled = false;
				addChild(leftSymbolMC);
				leftEdge += leftSymbolMC.width + PADDING;
			}
			
			// Then the left text
			if(leftString.length > 0){
				leftTextField = new TextField();
				addChild(leftTextField);
				leftTextField.x = leftEdge;
				leftTextField.defaultTextFormat = HeaderFormat.HEADER_ACTION_LEFT;
				leftTextField.text = leftString;
				leftTextField.autoSize = TextFieldAutoSize.LEFT;
				
				leftTextField.antiAliasType = "ADVANCED";
				leftTextField.selectable = false;
				leftTextField.mouseEnabled = false;
				leftEdge += leftTextField.width + PADDING;
			}
			
			// Then the right symbol
			var rightEdge = fullWidth/2 - (PADDING * 2);
			if(rightSymbol != HeaderBar.SYMBOL_NONE){
				rightSymbolMC = rightSymbol == HeaderBar.SYMBOL_PLUS ? new Plus() : new ArrowLeft();
				rightSymbolMC.x = rightEdge - rightSymbolMC.width;
				rightSymbolMC.y = HEIGHT/4;
				rightSymbolMC.mouseEnabled = false;
				addChild(rightSymbolMC);
				rightEdge -= (leftSymbolMC.width + PADDING);
			}
			
			// Then the right text
			if(rightString.length > 0){
				rightTextField = new TextField();
				addChild(rightTextField);
				rightTextField.defaultTextFormat = HeaderFormat.HEADER_ACTION_RIGHT;
				rightTextField.text = rightString;
				rightTextField.autoSize = TextFieldAutoSize.RIGHT;
				rightTextField.antiAliasType = "ADVANCED";
				rightTextField.selectable = false;
				rightTextField.mouseEnabled = false;
				rightTextField.x = rightEdge - rightTextField.width;
				rightEdge -= rightTextField.width + PADDING;
			}
			
			// Then the center text
			if( headerString.length > 0){
				headerTextField = new TextField();
				addChild(headerTextField);
				headerTextField.x = -fullWidth/2;
				headerTextField.defaultTextFormat = HeaderFormat.HEADER_CENTER;
				headerTextField.text = headerString;
				headerTextField.width = fullWidth;
				headerTextField.antiAliasType = "ADVANCED";
				headerTextField.selectable = false;
				headerTextField.mouseEnabled = false;
			}
			
			
			// Then adjust the button boxes
			leftHalfBtn.width = Math.abs(-fullWidth/2 - leftEdge);
			rightHalfBtn.width = fullWidth/2 - rightEdge;
			rightHalfBtn.x = fullWidth/2 - rightHalfBtn.width;
		}*/
		
		private function handleLeftTapped(e:MouseEvent):void{
			leftDelegate(new HeaderEvent(HeaderEvent.LEFT_TAPPED));
		}
		private function handleRightTapped(e:MouseEvent):void{
		}
		
	}
	
}
