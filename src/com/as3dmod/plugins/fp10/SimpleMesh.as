package com.as3dmod.plugins.fp10 {
	import com.as3dmod.core.MeshProxy;

	import flash.geom.Vector3D;

	/**
	 * @author bartekd
	 */
	public class SimpleMesh extends MeshProxy {
		
		private var sverts:Vector.<Vector3D>;
		
		public function SimpleMesh() {
			super();
		}
		
		override public function setMesh(mesh:*):void {
			sverts = mesh as Vector.<Vector3D>;

			var vc:int = sverts.length;
			
			for (var i:int = 0; i < vc; i++) {
				var nv:SimpleVertex = new SimpleVertex();
				nv.setVertex(sverts[i]);
				vertices.push(nv);
			}
		}
	}
}
