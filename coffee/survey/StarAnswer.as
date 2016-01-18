package coffee.survey   {
	
	public class StarAnswer extends Answer{
		
		public static const MIN_VALUE:int = 1;
		public static const MAX_VALUE:int = 5;
		
		protected var _answer:int;
		
		public function StarAnswer(answer:int, note:String = "") {
			super(note);
			this.answer = answer;
		}
		
		public function set answer(arg:int):void{
			if( arg < MIN_VALUE){
				arg = MIN_VALUE;
			} else if( arg > MAX_VALUE){
				arg = MAX_VALUE;
			}
			_answer = arg;
		}
		
		public function get answer():int{
			return _answer;
		}
	}
	
}
