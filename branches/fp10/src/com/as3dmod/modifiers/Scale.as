package com.as3dmod.modifiers {
	import com.as3dmod.IModifier;
	import com.as3dmod.core.Modifier;
	import com.as3dmod.core.VertexProxy;
	
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;	

	/**
	 * @author bartekd
	 */
	public class Scale extends Modifier implements IModifier {
		
		private var scaleVector:Vector3D;
		
		public function Scale(sx:Number, sy:Number, sz:Number) {
			scaleVector = new Vector3D(sx, sy, sz);
		}
		public function apply():void {
			var vs:Vector.<VertexProxy> = mod.getVertices();
			var vc:int = vs.length;

			for (var i:int = 0; i < vc; i++) {
				var v:VertexProxy = vs[i] as VertexProxy;
				var c:Vector3D = v.vector.clone();
				var s:Matrix3D = new Matrix3D();
				s.appendScale(scaleVector.x, scaleVector.y, scaleVector.z);
				c = s.transformVector(c);
				v.x = c.x;
				v.y = c.y;
				v.z = c.z;
			}
		}	}
}
