package com.as3dmod.modifiers {
	import com.as3dmod.IModifier;
	import com.as3dmod.core.Modifier;
	import com.as3dmod.core.VertexProxy;
	
	import flash.display.BitmapData;	

	/**
	 * 	<b>BitmapDisplacement modifier.</b> Displaces verttices based on RGB values of pixels. 
	 * 	<br>
	 * 	<p>BitmapDisplacement is inspired by both the AS3 built-in DisplacementMapFilter. It allows
	 * 	to use color values for each channels of a bitmap to modify the position of vertices in a mesh.
	 * 	
	 * 	<p>The displacement taks place along the cardinal axes, and each axis is mapped to a 
	 * 	channel in the bitmap: X for Red, Y for Green and Z for Blue.
	 * 	
	 * 	@version 1.0
	 * 	@author Bartek Drozdz
	 */
	public class BitmapDisplacement extends Modifier implements IModifier {

		protected var _force:Number;
		protected var _bitmap:BitmapData;
		
		protected var _colors:Vector.<uint>;		protected var _width:int;		protected var _height:int;
		protected var _numPixels:int;
		
		protected var _axes:int = 7;

		protected var offset:Number = 0x80;
		

		public function BitmapDisplacement(b:BitmapData, f:Number = 1) {
			_bitmap = b;
			_force = f;
			_width = _bitmap.width;			_height = _bitmap.height;
			_numPixels = _width * _height;
		}
		public function apply():void {
			_colors = _bitmap.getVector(_bitmap.rect);
			
			
			var vs:Vector.<VertexProxy> = mod.getVertices();
			var vc:int = vs.length;
			
			for (var i:int = 0;i < vc; i++) {
				var v:VertexProxy = vs[i];
				
				var uv:Number = getUVPixel(v.ratioX, v.ratioZ);

				if(axes & 1) v.x += ((uv >> 16 & 0xff) - offset) * _force;
				if(axes & 2) v.y += ((uv >> 8 & 0xff) - offset) * _force;
				if(axes & 4) v.z += ((uv & 0xff) - offset) * _force;
			}
		}

		public function getUVPixel(u:Number, v:Number):uint {
			var x:Number = (_width - 1) * u; 
			var y:Number = (_height - 1) * v;
			return _bitmap.getPixel32(x, y);
//			var i:int = Math.max(0, _width * (y - 1)) + x;
//			return _colors[i];
		}

		public function get force():Number {
			return _force;
		}

		public function set force(force:Number):void {
			_force = force;
		}

		public function get axes():int {
			return _axes;
		}

		public function set axes(axes:int):void {
			_axes = axes;
		}

		public function get bitmap():BitmapData {
			return _bitmap;
		}	}
}
