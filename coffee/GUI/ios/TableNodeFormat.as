package coffee.GUI.ios {
	import flash.text.TextFormat;
	
	public class TableNodeFormat {

		private static const FONT:String = "Museo Sans 500";
		
		// Text Formats
		private static var simpleFormat:TextFormat; // The standard format for text
		private static var dataFormat:TextFormat;
		private static var subtitleFormat:TextFormat;
		
		public static function get SIMPLE():TextFormat{
			if( !simpleFormat){
				simpleFormat = new TextFormat();
				simpleFormat.font = FONT;
				simpleFormat.size = 30;
				simpleFormat.align = "left";
				simpleFormat.color = 0x000000;
			} 
			return simpleFormat;
		}
		
		public static function get DATA():TextFormat{
			if( !dataFormat){
				dataFormat = new TextFormat();
				dataFormat.font = FONT;
				dataFormat.size = 30;
				dataFormat.align = "right";
				dataFormat.color = 0xB1B1B1;
			} 
			return dataFormat;
		}
		
		public static function get SUBTITLE():TextFormat{
			if( !subtitleFormat){
				subtitleFormat = new TextFormat();
				subtitleFormat.font = FONT;
				subtitleFormat.size = 23;
				subtitleFormat.align = "left";
				subtitleFormat.color = 0x000000;
			} 
			return subtitleFormat;
		}

	}
	
}
