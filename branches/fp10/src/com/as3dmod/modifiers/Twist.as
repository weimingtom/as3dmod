package com.as3dmod.modifiers {
	import com.as3dmod.IModifier;
	import com.as3dmod.core.Modifier;
	import com.as3dmod.core.VertexProxy;
	
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;	

	/**
	 * <b>Twist modifier.</b>
	 * 
	 * Adapted from the Twist modifier for PV3D. 
	 * More info here: <a href="http://blog.zupko.info/?p=140" target="_blank">http://blog.zupko.info/?p=140</a>.
	 */
	public class Twist extends Modifier implements IModifier {

		private var _vector:Vector3D = new Vector3D(0, 1, 0);
		private var _angle:Number;
		public var center:Vector3D = new Vector3D();

		public function Twist(a:Number = 0) {
			_angle = a;
			_vector.normalize();
		}

		public function get angle():Number { 
			return _angle; 
		}

		public function set angle(value:Number):void { 
			_angle = value; 
		}

		public function get vector():Vector3D { 
			return _vector; 
		}

		public function set vector(value:Vector3D):void { 
			_vector = value; 
			_vector.normalize();
		}

		public function apply():void {
			var vs:Vector.<VertexProxy> = mod.getVertices();
			var vc:int = vs.length;

			var dv:Vector3D = new Vector3D(mod.maxX / 2, mod.maxY / 2, mod.maxZ / 2);
			var d:Number = -_vector.dotProduct(center);

			for(var i:int = 0;i < vc; i++) {
				var vertex:VertexProxy = vs[i];
				var dd:Number = vertex.vector.dotProduct(_vector) + d;
				twistPoint(vertex, (dd / dv.length) * _angle);
			}
		}

		private function twistPoint(v:VertexProxy, a:Number):void {
			var mat:Matrix3D = new Matrix3D();
			mat.appendTranslation(v.x, v.y, v.z);	
			mat.appendRotation(a / Math.PI * 180, _vector);
			v.x = mat.rawData[12]; // n14
			v.y = mat.rawData[13]; // n24
			v.z = mat.rawData[14]; // n34
		}
	}
}