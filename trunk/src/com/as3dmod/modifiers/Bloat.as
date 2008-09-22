package com.as3dmod.modifiers {
	import com.as3dmod.core.Vector3D;
	import com.as3dmod.IModifier;
	import com.as3dmod.core.Modifier;
	import com.as3dmod.core.VertexProxy;	

	/**
	 * <b>Bloat modifier.</b>
	 * 
	 * Bloats your stuff by forcing vertices out of specified sphere.
	 * @author makc
	 */
	public class Bloat extends Modifier implements IModifier {

		private var _center:Vector3D = new Vector3D;
		public function get center ():Vector3D { return _center; }
		public function set center (v:Vector3D):void { _center = v; }

		private var _r:Number = 0;
		public function get radius ():Number { return _r; }
		public function set radius (v:Number):void { _r = Math.max (0, v); }

		private var _a:Number = 1e-2;
		public function get a ():Number { return _a; }
		public function set a (v:Number):void { _a = Math.max (0, v); }

		private var _u:Vector3D = new Vector3D;
		public function apply():void {
			var vs:Array = mod.getVertices();
			var vc:int = vs.length;

			for (var i:int = 0; i < vc; i++) {
				var v:VertexProxy = VertexProxy (vs [i]);

				// get a vector towards vertex
				_u.x = v.x; _u.y = v.y; _u.z = v.z;
				_u.subtract (_center);

				// change norm to norm + r * exp (-a * norm)
				_u.modulo += _r * Math.exp ( - _u.modulo * _a);

				// move vertex accordingly
				_u.add (_center);
				v.x = _u.x; v.y = _u.y; v.z = _u.z;
			}
		}

	}
	
}