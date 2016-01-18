package coffee.GUI {
	
	/*
	Notes
	|
	|-- NotesText (Multiline textbox)
	
	*/
	import flash.display.MovieClip;
	
	
	public class Notes extends MovieClip {
		
		
		public function Notes() {
			// constructor code
			clearNotes();
		}
		
		public function clearNotes():void{
			NotesText.text = "";
		}
		
		public function getNotes():String{
			return NotesText.text;
		}
		
		public function hasNotes():Boolean{
			return NotesText.text.length > 0;
		}
	}
	
}
