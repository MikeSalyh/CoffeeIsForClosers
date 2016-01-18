package coffee.GUI {
	/*
	SurveyGUI
	|
	|-- RecurranceText (TextBox, single line)
	|-- RecurranceBg (MovieClip)
	|
	|-- QuestionText (TextBox, multiline)
	|-- <<Input>> {Must Be Added w/ code}
	|-- NotesMc (Notes)
	|
	|-- DoneBtn
	|-- BackBtn (SimpleButton)
	|-- EditBtn (SimpleButton)
	|
	|-- Background
	|-- Footer
	
	
	
	
	
	
	
	*/
	
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fl.motion.Color;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import coffee.survey.Survey;
	import coffee.survey.SurveyRecurrance;
	import coffee.survey.SurveyTypes;
	import flash.text.TextField;
	import flash.filters.BitmapFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.BitmapFilterQuality;
	import fl.transitions.Tween;
	import fl.transitions.easing.Regular;
	import fl.transitions.TweenEvent;
	
	
	public class SurveyGUI extends MovieClip {
		
		// Colors
		private static const LIGHT_BROWN:uint = 0xC9711A, BROWN:uint = 0x843828, DARK_BROWN:uint = 0x291F15;
		private static const QUESTION_LINE_HEIGHT:int = 55, QUESTION_PADDING:int = 125, MAX_LINES_QUESTION:int = 3;
		private static const NOTES_PADDING:int = 65, FOOTER_BTN_PADDING:int = 5;
		
		private var _survey:Survey;
		private var _notes:Notes;
		private var _input:SurveyInput;
		private var tweenX:Tween; 
		
		
		public function SurveyGUI( survey:Survey, stageWidth:int, x:Number, y:Number) {
			// constructor code
			//this.x = x;
			this.y = y;
			this._survey = survey;
			build( survey);			
			addDropShadow();
			SlideCardIn(stageWidth, x);
		}
		
		private function build( arg:Survey):void{
			// First, build the header bar.
			RecurranceText.text = arg.recurrance;
			var c:Color = new Color();
			switch(arg.recurrance){
				case SurveyRecurrance.DAILY:
					c.setTint(LIGHT_BROWN, 1);
					break;
				case SurveyRecurrance.WEEKLY:
					c.setTint(BROWN, 1);
					break;
				case SurveyRecurrance.MONTHLY:
				default:
					c.setTint(DARK_BROWN, 1);
					break;
			}
			RecurranceBg.transform.colorTransform = c;
			
			// Then, build the question
			QuestionText.text = arg.question;
			var numLines:int = (QuestionText as TextField).numLines > 3 ? 3 : (QuestionText as TextField).numLines;
			
			// Then, add the input.
			switch(arg.type){
				case SurveyTypes.BOOLEAN:
					_input = new BooleanButtons();
					break;
				case SurveyTypes.TEXT:
					_input = new TextAnswer();
					break;
				case SurveyTypes.STAR:
					_input = new StarRanking();
					break;
				default:
					throw new Error("Bad type. See Survey public consts.");
					break;
			}
			addChild( _input as MovieClip);
			_input.y = RecurranceText.y + (numLines * QUESTION_LINE_HEIGHT) + QUESTION_PADDING;
			
			
			// Then, square up the notes section
			_notes = new Notes();
			addChild( _notes);
			_notes.y =  _input.y + _input.height + NOTES_PADDING;
			
			// Then, adjust the backing height
			Background.height = _notes.y + _notes.height;
			
			// Then, the footer and all its buttons.
			Footer.y = Background.y + Background.height;
			DoneBtn.y = Footer.y;
			BackBtn.y = Footer.y - FOOTER_BTN_PADDING;
			EditBtn.y = Footer.y - FOOTER_BTN_PADDING;
			
			// Ok, it's looking good!
			// Now we need to add the event listeners:
			
			_input.addEventListener(SurveyGUIEvent.RECIEVE_INPUT, (DoneBtn as DoneButton).show);
			_input.addEventListener(SurveyGUIEvent.CLEAR_INPUT, (DoneBtn as DoneButton).hide);
			DoneBtn.addEventListener( MouseEvent.MOUSE_DOWN, submit);
		}
		
		
		private function submit( e:Event = null):void{
			DoneBtn.close(e);
			DoneBtn.removeEventListener( MouseEvent.CLICK, submit);
			SlideCardAway();
			//_survey.sendAnswer(_input.getInput(), _notes.getNotes());
		}
		
		
		
		
		private function SlideCardIn(stageEdgeX:int, tagetX:int):void{
			tweenX = new Tween(this, "x", fl.transitions.easing.Strong.easeOut, stageEdgeX + Background.width, tagetX, 0.8, true);
		}
		
		private function SlideCardAway():void{
			tweenX = new Tween(this, "x", fl.transitions.easing.Regular.easeIn, x, 0 - Background.width, 0.6, true);
			tweenX.addEventListener(TweenEvent.MOTION_FINISH, destroyThis);
		}
		
		private function destroyThis(e:Event):void{
			dispatchEvent( new SurveyGUIEvent( SurveyGUIEvent.COMPLETE));
			if(this.parent){
				this.parent.removeChild(this);
			}
		}
		
		
		private function addDropShadow():void{
            var filter:BitmapFilter = getBitmapFilter();
            var myFilters:Array = new Array();
            myFilters.push(filter);
            filters = myFilters;
        }

        private function getBitmapFilter():BitmapFilter {
            var color:Number = 0x000000;
            var angle:Number = 60;
            var alpha:Number = 0.8;
            var blurX:Number = 5;
            var blurY:Number = 5;
            var distance:Number = 6;
            var strength:Number = 0.20;
            var inner:Boolean = false;
            var knockout:Boolean = false;
            var quality:Number = BitmapFilterQuality.LOW;
            return new DropShadowFilter(distance,
                                        angle,
                                        color,
                                        alpha,
                                        blurX,
                                        blurY,
                                        strength,
                                        quality,
                                        inner,
                                        knockout);
        }
		
		
		
	}
	
}
