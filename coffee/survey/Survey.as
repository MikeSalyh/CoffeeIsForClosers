package coffee.survey {
	
	import coffee.utils.GUID;
	
	//CoffeeIsForClosers is about self surveys. A survey is the highest unit of data.
	//A survey contains a question, a vector of answers, and instructions for graphing this information.
	
	public class Survey {
		
		// ------------
		
		// A unique identifier for this survey
		private var _id:String;
		
		// How often this survey recurrs.
		private var _recurrance:String;
		
		// The question in this survey
		private var _question:String;
		
		private var _type:String;
		
		// The answers gathered from this survey. 
		// This should probably be handled by some kind of back-end system eventually.
		private var _answers:Vector.<Answer>;
		
		
		
		public function Survey(recurrance:String, type:String, question:String) {
			// constructor code
			this._id = GUID.create();
			
			this.recurrance = recurrance;
			this.question = question;
			this.type = type;
			_answers = new Vector.<Answer>();
		}
		
		public function get ID():String{
			return _id;
		}
		
		public function set question( arg:String):void{
			_question = arg;
		}
		
		public function get question():String{
			return _question;
		}
		
		// Set the survey's recurrance
		public function set recurrance( arg:String):void{
			switch(arg){
				case SurveyRecurrance.DAILY:
				case SurveyRecurrance.WEEKLY:
				case SurveyRecurrance.MONTHLY:
					_recurrance = arg;
					break;
				default:
					throw new Error("Invalid recurrance: " + arg + ". Use class consts in coffee.survey.SurveyRecurrance.");
					break;
			}
		}
		
		// Get the survey's recurrance
		public function get recurrance():String{
			return _recurrance;
		}
		
		public function get type():String{
			return _type;
		}
		
		// Set the survey's recurrance
		public function set type( arg:String):void{
			switch(arg){
				case SurveyTypes.BOOLEAN:
				case SurveyTypes.STAR:
				case SurveyTypes.TEXT:
					_type = arg;
					break;
				default:
					throw new Error("Invalid type: " + arg + ". Use class consts in coffee.survey.SurveyTypes.");
					break;
			}
		}
		
		
		
		public function answer( answer:Object, notes:String):void{
			//WIP.
		}
		
		
		// Serialize the string into JSON formatting
		public function serialize():String{
			// WIP. Serialize the string into JSON formatting for server-side logging.
			return("");
		}
		
		

	}
	
}
