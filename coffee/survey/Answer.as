package coffee.survey {
	
	public class Answer {

		protected var _date:Date;
		protected var _note:String;

		public function Answer( note:String = "") {
			// constructor code
			this.note = note;
			_date = new Date();
		}
		
		public function get date():Date{
			return _date;
		}
		
		public function set note( arg:String):void{
			_note = arg;
		}
		
		public function get note():String{
			return _note;
		}

	}
	
}
