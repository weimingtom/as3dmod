package com.as3dmod.modifiers {
	
	import com.as3dmod.core.Modifier;
	import com.as3dmod.core.VertexProxy;
	import com.as3dmod.IModifier;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.BitmapDataChannel;

	public class Perlin extends Modifier implements IModifier {
		
		private var b:BitmapData = null;
		public var o:Number = 0;
		
		public function Perlin() {
			b = new BitmapData(25, 11);
		}
		
		public function apply():void {
			var p:Point = new Point(o++, 0);
			b.perlinNoise(25, 11, 1, 9830, false, false, BitmapDataChannel.RED, true, [p, p, p]);
			
			var vs:Array = mod.getVertices();
			var vc:int = vs.length;
			
			for (var i:int = 0; i < vc; i++) {
                var px:int = i % 11;
                var py:int = i / 11;
                var v:VertexProxy = vs[i] as VertexProxy;
                var vzpos:Number = b.getPixel(py, px) & 0xff;
                //v.setValue(mod.minAxis, (128 - vzpos) * .3);
                v.setValue(mod.minAxis, (128 - vzpos));
            }
		}
	}
	
}