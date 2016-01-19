package coffee.survey {
	
	public class Answer {

		protected var _date:Date;
		protected var _note:String;
		protected var _answer:Object;

		public function Answer( answer:Object, note:String = "") {
			// constructor code
			this.answer = answer;
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
		
		public function hasNote():Boolean{
			return _note.length > 0;
		}
		
		public function get answer():Object{
			return _answer;
		}
		
		public function set answer( arg:Object):void{
			_answer = arg;
		}
		
		
		public function toString():String{
			if( hasNote())
				return String(answer) + ", " + note;
			else
				return String(answer);
		}

	}
	
}
