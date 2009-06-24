package com.as3dmod.components.common {
	import flash.display.Sprite;

	/**
	 * @author bartekd
	 */
	public class Corner extends Sprite {
		
		public static const TOP_LEFT:int = 0;		public static const TOP_RIGHT:int = 1;		public static const BOTTOM_LEFT:int = 2;		public static const BOTTOM_RIGHT:int = 3;
		
		public function Corner(which:int, size:int) {
			buttonMode = true; 
			
			graphics.beginFill(0xff0000, .3);
			graphics.moveTo(0, 0);
			
			switch(which) {
				case TOP_LEFT:
					graphics.lineTo(size, 0);					graphics.lineTo(0, size);					graphics.lineTo(0, 0);
					break;
				case TOP_RIGHT:
					graphics.lineTo(-size, 0);
					graphics.lineTo(0, size);
					graphics.lineTo(0, 0);
					break;
				case BOTTOM_LEFT:
					graphics.lineTo(size, 0);
					graphics.lineTo(0, -size);
					graphics.lineTo(0, 0);
					break;
				case BOTTOM_RIGHT:
					graphics.lineTo(-size, 0);
					graphics.lineTo(0, -size);
					graphics.lineTo(0, 0);
					break;
			}
			graphics.endFill();
		}
	}
}
