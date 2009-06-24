package com.as3dmod.components.common {
	import flash.geom.Vector3D;

	/**
	 * @author bartekd
	 */
	public class Face {

		public var a:Vector3D;
		public var b:Vector3D;
		public var c:Vector3D;
		public var d:Vector3D;

		public var auv:UV;		public var buv:UV;		public var cuv:UV;		public var duv:UV;

		// Layout:
		//  a b
		//  d c

		private var rvert:Vector.<Vector3D>;		private var ruvs:Vector.<Number>;

		public function Face() {
		}

		public function getRenderVertices():Vector.<Vector3D> {
			if(rvert == null) {
				rvert = new Vector.<Vector3D>(6);
				rvert[0] = a;				rvert[1] = b;				rvert[2] = c;				rvert[3] = a;				rvert[4] = c;				rvert[5] = d;
			}
			return rvert;
		}

		public function getVertices():Vector.<Vector3D> {
			return Vector.<Vector3D>([a, b, c, d]);
		}

		public function getUVS():Vector.<Number> {
			ruvs = new Vector.<Number>();
			ruvs.push(auv.u, auv.v);
			ruvs.push(buv.u, buv.v);			ruvs.push(cuv.u, cuv.v);			ruvs.push(auv.u, auv.v);			ruvs.push(cuv.u, cuv.v);			ruvs.push(duv.u, duv.v);
			return ruvs;
		}

		
		
		public function traceUV():String {
			return auv.u + " : " + auv.v + " / " + buv.u + " : " + buv.v + " / " + cuv.u + " : " + cuv.v + " / " + duv.u + " : " + duv.v + " / ";
		}
	}
}
