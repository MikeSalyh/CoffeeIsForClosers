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
	
	public class TableView extends MovieClip{

		private var _bg:MovieClip;
		private var _nodes:Vector.<TableNode>;
		private var _nodeHolder:MovieClip;
		
		//private var _isDragging:Boolean = false;
		private var _scrollBar:Shape;
		
		public function TableView(x:Number, y:Number, width:Number, height:Number) {
			// constructor code
			this.x = x;
			this.y = y;
			
			// Put a background behind the screen
			_bg = addChild(new MovieClip()) as MovieClip;
			_bg.addChild(createRect(width, height));
			_bg.addEventListener( MouseEvent.MOUSE_DOWN, handleNodeTapped);			
			
			_nodes = new Vector.<TableNode>();
			_nodeHolder = addChild(new MovieClip()) as MovieClip;
			
			_nodeHolder.addEventListener( TableEvent.NODE_TAPPED, handleNodeTapped);
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
		
		public function init():void{
			var nodeHeight:Number = 0;
			for( var i:int = 0; i < _nodes.length; i++){
				var nextNode:TableNode = _nodes[i];
				_nodeHolder.addChild(nextNode);
				nextNode.y = nodeHeight;
				nodeHeight += nextNode.height;
			}
			
			_scrollBar = addChild(buildScrollBar()) as Shape;
			_scrollBar.visible = false;
		}
		
		public function addNode(node:TableNode):void{
			_nodes.push(node);
		}
		
		//When a node gets tapped, handle that logic.
		private function handleNodeTapped(e:Event):void{
			var dragWindow = _nodeHolder.height > _bg.height ? _nodeHolder.height : _bg.height;
			_nodeHolder.startDrag(false, new Rectangle(0, -dragWindow, 0, dragWindow*2));
			_nodeHolder.addEventListener(MouseEvent.MOUSE_UP, handleNodeReleased);
			stage.addEventListener(MouseEvent.MOUSE_UP, handleNodeReleased);
			removeEventListener( Event.ENTER_FRAME, handlePushback);
			
			if( isScrollable()){
				_scrollBar.visible = true;
				addEventListener( Event.ENTER_FRAME, handleScrollBar);
			}
		}
		
		private function handleNodeReleased(e:Event):void{
			_nodeHolder.stopDrag();
			_nodeHolder.removeEventListener(MouseEvent.MOUSE_UP, handleNodeReleased);
			stage.removeEventListener(MouseEvent.MOUSE_UP, handleNodeReleased);
			addEventListener( Event.ENTER_FRAME, handlePushback);
		}
		
		// This code handles when the view goes offscreen. It pushes it back onscreen.
		private function handlePushback( e:Event):void{
			const PUSHBACK_SPEED:int = 4;
			var dY:Number = 0;
			
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
		
		
		// TODO: Momentum scrolling (low priority). Make the scrolling play nice with actions (high priority).

	}
	
}
