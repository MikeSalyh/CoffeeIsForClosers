package coffee.survey {
	
	public class BooleanAnswer extends Answer{

		protected var _answer:Boolean;
		
		public function BooleanAnswer( answer:Boolean, note:String = ""):void{
			super(note);
			this.answer = answer;
		}
		
		public function set answer(arg:Boolean):void{
			_answer = arg;
		}
		
		public function get answer():Boolean{
			return _answer;
		}

	}
	
}
