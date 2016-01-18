package coffee.survey {
	
	public class TextAnswer extends Answer{

		protected var _answer:String;
		
		public function NumberAnswer(answer:String, note:String = "") {
			super(note);
			this.answer = answer;
		}
		
		public function set answer(arg:String):void{
			_answer = arg;
		}
		
		public function get answer():String{
			return _answer;
		}
		
		

	}
	
}
