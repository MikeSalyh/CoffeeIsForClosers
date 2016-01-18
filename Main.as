package
{
	import flash.display.Sprite;
	import coffee.GUI.SurveyGUI;
	import coffee.GUI.SurveyGUIEvent;
	import coffee.survey.*;
	import flash.events.Event;
	
	public class Main extends Sprite
	{
		public static const STAGE_WIDTH:int = 750;
		public static const STAGE_HEIGHT:int = 1334;
		
		public static var SurveyY = 170;
		
		public function Main()
		{
			surveys = [mySurvey1, mySurvey2, mySurvey3, mySurvey4];
			makeSurvey();
		}
		
		var mySurvey1 = new Survey(SurveyRecurrance.DAILY, SurveyTypes.BOOLEAN, "Did you lift today?");
		var mySurvey2 = new Survey(SurveyRecurrance.WEEKLY, SurveyTypes.STAR, "How productive were you this week?");
		var mySurvey3 = new Survey(SurveyRecurrance.WEEKLY, SurveyTypes.BOOLEAN, "Is your appartment clean?");
		var mySurvey4 = new Survey(SurveyRecurrance.MONTHLY, SurveyTypes.TEXT, "What's your Meyers Briggs type?");
		var surveys;
		
		
		public function makeSurvey( e:Event = null):void{
			var mySurveyGUI = new SurveyGUI(getRandomSurvey(), STAGE_WIDTH, STAGE_WIDTH/2, SurveyY);
			addChild( mySurveyGUI);
			mySurveyGUI.mask = CardMask;
			mySurveyGUI.addEventListener( SurveyGUIEvent.COMPLETE, makeSurvey);
		}
		
		private function getRandomSurvey():Survey{
			var out:Survey = surveys.shift();
			surveys.push(out);
			return out;
		}
	}
}