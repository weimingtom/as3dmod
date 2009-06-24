package com.as3dmod.components.common {
	import flash.geom.ColorTransform;
	import flash.display.DisplayObject;
	import flash.display.BitmapData;

	/**
	 * @author bartekd
	 */
	public class Material extends BitmapData {
		
		private var texture:DisplayObject;
		
		public function Material(texture:DisplayObject) {
			this.texture = texture;
			super(texture.width, texture.height, true, 0x00000000);
			update();
		}
		
		public function update(cl:ColorTransform = null):void {
			draw(texture, null, cl);
		}
	}
}
