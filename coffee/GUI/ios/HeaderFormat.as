package coffee.GUI.ios {
	import flash.text.TextFormat;
	
	public class HeaderFormat {

		private static const FONT:String = "Museo Sans 500";
		
		// Text Formats
		private static var headerActionFormat:TextFormat;
		private static var headerFormat:TextFormat;
		
		public static function get HEADER_ACTION_LEFT():TextFormat{
			if( !headerActionFormat){
				headerActionFormat = new TextFormat();
				headerActionFormat.font = FONT;
				headerActionFormat.size = 30;
				headerActionFormat.color = 0x843828;
			} 
			headerActionFormat.align = "left";
			return headerActionFormat;
		}
		
		public static function get HEADER_ACTION_RIGHT():TextFormat{
			if( !headerActionFormat){
				headerActionFormat = new TextFormat();
				headerActionFormat.font = FONT;
				headerActionFormat.size = 30;
				headerActionFormat.color = 0x843828;
			} 
			headerActionFormat.align = "right";
			return headerActionFormat;
		}
		
		/*
		public static function get HEADER_LEFT():TextFormat{
			if( !headerFormat){
				headerFormat = new TextFormat();
				headerFormat.font = FONT;
				headerFormat.size = 30;
				headerFormat.color = 0x000000;
			} 
			headerFormat.align = "left";
			return headerFormat;
		}*/
		
		public static function get HEADER_CENTER():TextFormat{
			if( !headerFormat){
				headerFormat = new TextFormat();
				headerFormat.font = FONT;
				headerFormat.size = 30;
				headerFormat.color = 0x000000;
			} 
			headerFormat.align = "center";
			return headerFormat;
		}
	}
	
}
