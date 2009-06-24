package com.as3dmod.plugins.fp10 {
	import com.as3dmod.core.VertexProxy;
	
	import flash.geom.Vector3D;	

	/**
	 * @author bartekd
	 */
	public class SimpleVertex extends VertexProxy {
		
		private var vx:Vector3D;

		public function SimpleVertex() {
			super();
		}
		
		override public function setVertex(vertex:*):void {
			vx = vertex as Vector3D;
			ox = vx.x;
			oy = vx.y;
			oz = vx.z;
		}
		
		override public function get x():Number {
			return vx.x;
		}
		
		override public function get y():Number {
			return vx.y;
		}
		
		override public function get z():Number {
			return vx.z;
		}
		
		override public function set x(v:Number):void {
			vx.x = v;
		}
		
		override public function set y(v:Number):void {
			vx.y = v;
		}
		
		override public function set z(v:Number):void {
			vx.z = v;
		}
	}
}
