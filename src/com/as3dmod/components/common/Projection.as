package com.as3dmod.components.common {
	import flash.geom.Vector3D;	
	
	/**
	 * @author bartekd
	 */
	public class Projection {

		public var vpx:Number;
		public var vpy:Number;
		public var fl:Number;

		public function Projection(vpx:Number=0, vpy:Number=0, fl:Number=1000) {
			this.fl = fl;
			this.vpy = vpy;
			this.vpx = vpx;
		}

		public function projectVector(v:Vector3D):void {
			var d:Number = fl / (fl + v.z);
			v.x = vpx + v.x * d;
			v.y = vpy + v.y * d;
			v.w = d;
		}
	}
}
