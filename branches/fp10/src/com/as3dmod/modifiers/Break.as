package com.as3dmod.modifiers {
	import com.as3dmod.IModifier;
	import com.as3dmod.core.MeshProxy;
	import com.as3dmod.core.Modifier;
	import com.as3dmod.core.VertexProxy;
	import com.as3dmod.util.Range;
	
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;		

	/**
	 * <b>Break.</b> Allow to break a mesh.
	 * <br>
	 * <p>This is the inital version of the class, it contains some 
	 * hardcoded values that would make it unusable in most situations. 
	 * 
	 * <p>Updates coming soon.
	 * 
	 * @version 0
	 * @author Bartek Drozdz
	 */
	public class Break extends Modifier implements IModifier {
		private var bv:Vector3D = new Vector3D(0, 0, 1);
		public var _offset:Number;
		public var angle:Number;
				public var range:Range = new Range(0,1);

		public function Break(o:Number = 0, a:Number = 0) {
			this.angle = a;
			this._offset = o;
		}

		public function apply():void {
			var vs:Vector.<VertexProxy> = mod.getVertices();
			var vc:int = vs.length;
			var pv:Vector3D = new Vector3D(0, -(mod.minY + mod.height * offset), 0);
			

			for (var i:int = 0;i < vc; i++) {
				var v:VertexProxy = vs[i];
				var c:Vector3D = v.vector;
				c = c.add(pv);

				if(c.y >= 0 && range.isIn(v.ratioZ)) {
					var ta:Number = angle;
					var rm:Matrix3D = new Matrix3D();
					rm.appendRotation(ta / Math.PI * 180, bv);
					c = rm.transformVector(c);
				}

				
				var npv:Vector3D = pv.clone();
				npv.negate();
				c = c.add(npv);
			
				v.x = c.x;
				v.y = c.y;
				v.z = c.z;
			}
		}

		public function get offset():Number {
			return _offset;
		}

		public function set offset(offset:Number):void {
			_offset = offset;
		}
	}
}
