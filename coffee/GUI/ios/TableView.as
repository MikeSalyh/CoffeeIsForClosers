package coffee.GUI.ios {
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.geom.Rectangle;
	import flash.display.Shape;
	import fl.motion.Color;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import fl.transitions.Tween;
	import fl.transitions.easing.Regular;
	import flash.display.DisplayObject;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.None;
	
	public class TableView extends MovieClip{

		private var _bg:MovieClip;
		private var _nodes:Vector.<TableNode>;
		private var _nodeHolder:MovieClip;
		private var startX:Number;
		
		// --- SCROLLING VARIABLES ----
		
		//private var _isDragging:Boolean = false;
		private var _scrollBar:Shape;
		
		// The Y value of the mouse, when it clicks down on the nodeholder.
		private var mouseYOnDown:Number = Number.MIN_VALUE;
		
		// The Y value of the nodeholder when it's clicked on.
		private var startingNodeHolderY:Number = 0;
		
		// An array of the speed of the last 5 mouse moves. Used for scrolling intertia.
		private var lastMoves:Array = new Array(0,0,0,0,0);;
		
		// How many px the nodeHolder will scroll with intertia when released every frame.
		private var drift:Number;
		
		
		
		public function TableView(x:Number, y:Number, width:Number, height:Number) {
			// constructor code
			startX = x;
			this.x = startX;
			this.y = y;
			
			// Put a background behind the screen
			_bg = addChild(new MovieClip()) as MovieClip;
			_bg.addChild(createRect(width, height));
			_bg.addEventListener( MouseEvent.MOUSE_DOWN, handleNodePressed);			
			
			_nodes = new Vector.<TableNode>();
			
			_nodeHolder = addChild(new MovieClip()) as MovieClip;
			_nodeHolder.addEventListener( MouseEvent.MOUSE_DOWN, handleNodePressed);
		}
		
		private function createRect(width:Number, height:Number, color:uint = 0xFFFFFF):Shape{
			var bg:Shape = new Shape();
			bg.graphics.beginFill(color, 1);
			bg.graphics.lineTo(0,height);
			bg.graphics.lineTo(width, height);
			bg.graphics.lineTo(width, 0);
			bg.graphics.lineTo(0,0);
			bg.graphics.endFill();
			return bg;
		}
		
		public function init(flyIn:Boolean = true):void{
			var nodeHeight:Number = 0;
			for( var i:int = 0; i < _nodes.length; i++){
				var nextNode:TableNode = _nodes[i];
				_nodeHolder.addChild(nextNode);
				nextNode.y = nodeHeight;
				nodeHeight += nextNode.height;
			}
			
			_scrollBar = addChild(buildScrollBar()) as Shape;
			_scrollBar.visible = false;
			
			if(flyIn){
				fly(x + _bg.width, x);
			}
			
		}
		
		public function addNode(node:TableNode):void{
			_nodes.push(node);
		}
		
		
		//When anything is tapped in the view, it could potentially be the start of a drag.
		private function handleNodePressed(e:MouseEvent):void{
			//Stop any auto-scrolling.
			removeEventListener( Event.ENTER_FRAME, handlePushback);
			lastMoves  = new Array(0,0,0,0,0);

			//Listen for when the user's find is released.
			stage.addEventListener(MouseEvent.MOUSE_UP, handleNodeReleased);
			
			//The Y value that the nodeholder was at, at the time it was clicked.
			startingNodeHolderY = _nodeHolder.y;
			mouseYOnDown = e.stageY;
			
			
			//Listen for drag.
			stage.addEventListener(MouseEvent.MOUSE_MOVE, checkForDrag);
		}
		
		private function checkForDrag(e:MouseEvent):void{
			const DRAG_THRESHOLD:int = 10;
			
			var dY:Number =  e.stageY - mouseYOnDown;
			if( Math.abs(dY) > DRAG_THRESHOLD){
				//The user is trying to drag. Active dragging.
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, checkForDrag);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, handleDrag);
				ActionNode.enabled = false; //action nodes can't fire while dragging.
							
				// If the nodeHolder is bigger than the table view, show a scrollbar.
				if( isScrollable()){
					_scrollBar.visible = true;
					addEventListener( Event.ENTER_FRAME, handleScrollBar);
				}
			}
			
		}
		
		// Move the nodeHolder as its dragged around.
		private function handleDrag(e:MouseEvent):void{
			var beforeValue:Number = _nodeHolder.y;
			
			// Move the nodeHolder
			_nodeHolder.y = e.stageY - mouseYOnDown + startingNodeHolderY;		
			
			// And record its position, for interia when released.
			lastMoves.unshift();
			lastMoves.push(beforeValue - _nodeHolder.y);
		}
		
		private function handleNodeReleased(e:Event):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP, handleNodeReleased);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleDrag);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, checkForDrag);
			
			// If this is scrollable, calculate intertia.
			if( isScrollable())
				drift = calculateIntertia();
			
			addEventListener( Event.ENTER_FRAME, handlePushback);
			ActionNode.enabled = true;
		}
		
		private function calculateIntertia():Number{
			const MAX:int = 30, MIN:int = -30, MULTIPLIER:Number = 2;
			
			//calculate drift of release velocity.
			var out = 0;
			for( var i:int = 0; i < lastMoves.length; i++){
				out += lastMoves[i];
			}
			out /= lastMoves.length;
			
			out = Math.min(out, MAX);
			out = Math.max(out, MIN);
			out *= MULTIPLIER;
			
			return out;
		}
		
		// This code handles when the view goes offscreen. It pushes it back onscreen.
		private function handlePushback( e:Event):void{
			const PUSHBACK_SPEED:int = 4, INTERTIA_DECAY:Number = 1.15;
			var dY:Number = drift;
			
			drift /= INTERTIA_DECAY;
			
			// See how far offset the scroll menu is from where it should be. 
			// dY is how many pixels it should move this frame.
			
			if( isScrollable()){
				// If there's a scroll-able amount of nodes.
				var bottomPos:Number = (_nodeHolder.y + _nodeHolder.height);
				if( _nodeHolder.y > 1){
					// If the top of the nodes are below the top of the table, move them up
					dY = _nodeHolder.y/PUSHBACK_SPEED;
				} else if(bottomPos < _bg.height){
					dY = (bottomPos - _bg.height)/(PUSHBACK_SPEED*2);
				}
			} else if( Math.abs( _nodeHolder.y) > 1){
				dY = _nodeHolder.y/PUSHBACK_SPEED;
			}
			
			// Then, if the amount offset is larger than 1px, move. Otherwise, scrolling is done.
			if( Math.abs( dY) > 1){
				_nodeHolder.y -= dY;
			} else {
				removeEventListener( Event.ENTER_FRAME, handlePushback);
				if( isScrollable()){
					// Hide the scroll bar
					_scrollBar.visible = false;
					removeEventListener( Event.ENTER_FRAME, handleScrollBar);
				}
			}
		}


		// creates a scroll bar
		private function buildScrollBar():Shape{
			const SCROLL_WIDTH:int = 5;
			const SCROLL_COLOR:uint = 0xB1B1B1;
			
			var barHeight:int;
			if( _nodeHolder.height > _bg.height){
				barHeight = _bg.height * (_bg.height/_nodeHolder.height);
			} else {
				barHeight = _bg.height;
			}
			
			var b:Shape = createRect(SCROLL_WIDTH, barHeight, SCROLL_COLOR);
			b.x = _bg.width - b.width - 3;
			
			return b;
		}

		private function handleScrollBar(e:Event):void{
			const BUFFER:int = 12;
			var bottomPos:int = -(_nodeHolder.height - _bg.height);
			var percentage:Number = _nodeHolder.y/bottomPos;
			var offset:Number = _scrollBar.height * percentage;
			_scrollBar.y = BUFFER + (_bg.height - BUFFER*2) * percentage- offset;
		}
		
		private function isScrollable():Boolean{
			return _nodeHolder.height > _bg.height;
		}		
		
		
		// --- ENTERING & HIDING FUNCTIONS ---
		
		private var greyBox:MovieClip;
		
		
		public function showGreyOverlay():void{
			if(greyBox == null){
				greyBox = new MovieClip();
				greyBox.addChild(createRect(width, height));
				greyBox.alpha = 0.8;
				addChild(greyBox);
			} else {
				greyBox.visible = true;
			}
			fly(x, startX-50, 0.2);
		}
		
		public function hideGreyOverlay():void{
			if(greyBox != null){
				greyBox.visible = false;
			}
			fly(startX-50, startX, 0.2);
		}
		
		private var flyTween:Tween;
		public function fly(startX:int, endX:int, seconds:Number = 0.3):void{
			flyTween = new Tween(this, "x", fl.transitions.easing.None.easeNone, startX, endX, seconds, true);
		}
		
		public function closeAndDestroy(e:Event = null):void{
			fly(x, x + _bg.width);
			flyTween.addEventListener(TweenEvent.MOTION_FINISH, destroy);
		}
		
		
		public function destroy(e:Event = null):void{			
			// remove all listeners
			_bg.removeEventListener( MouseEvent.MOUSE_DOWN, handleNodePressed);	
			_nodeHolder.removeEventListener( MouseEvent.MOUSE_DOWN, handleNodePressed);
			stage.removeEventListener(MouseEvent.MOUSE_UP, handleNodeReleased);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, checkForDrag);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleDrag);
			removeEventListener( Event.ENTER_FRAME, handleScrollBar);
			removeEventListener( Event.ENTER_FRAME, handlePushback);
			flyTween.removeEventListener(TweenEvent.MOTION_FINISH, destroy);
			
			if(this.parent && this.parent.contains(this)){
				this.parent.removeChild(this);
			}
			
		}
	}
	
}
