package com.as3dmod.modifiers {
	import com.as3dmod.IModifier;
	import com.as3dmod.core.Modifier;
	import com.as3dmod.core.VertexProxy;
	import com.as3dmod.util.Math3D;
	
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;		

	/**
	 * 	<b>Taper modifier.</b>
	 * 	
	 * 	The taper modifier displaces the vertices on two 
	 * 	axes proportionally to their position on the third axis.
	 * 	
	 * 	@author Bartek Drozdz
	 */
	public class Taper extends Modifier implements IModifier {
		private var frc:Number;		private var pow:Number;

		private var start:Number = 0;
		private var end:Number = 1;

		private var _vector:Vector3D = new Vector3D(1, 0, 1);		private var _vector2:Vector3D = new Vector3D(0, 1, 0);

		public function Taper(f:Number) {
			frc = f;
			pow = 1;
		}

		public function setFalloff(start:Number = 0, end:Number = 1):void {
			this.start = start;
			this.end = end;
		}

		public function set force(value:Number):void {
			frc = value;
		}

		public function get force():Number {
			return frc;
		}

		public function get power():Number { 
			return pow; 
		}

		public function set power(value:Number):void { 
			pow = value; 
		}

		public function apply():void {
			var vs:Array = mod.getVertices();
			var vc:int = vs.length;
			
			for (var i:int = 0;i < vc; i++) {
				var v:VertexProxy = vs[i] as VertexProxy;
				
				var ar:Vector3D = Math3D.multiplyVectors(v.ratioVector, _vector2);
				var sc:Number = frc * Math.pow(ar.length, pow);
				
				var m:Matrix3D = new Matrix3D();
				m.appendScale(1 + sc * _vector.x, 1 + sc * _vector.y, 1 + sc * _vector.z);
				var n:Vector3D = v.vector;
				
				n = m.transformVector(n);
				v.vector = n;
			}
		}
	}
}







