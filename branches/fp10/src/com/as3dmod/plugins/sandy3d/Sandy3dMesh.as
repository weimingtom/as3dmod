package com.as3dmod.plugins.sandy3d {
	import sandy.core.data.Vertex;
	import sandy.core.scenegraph.Shape3D;
	
	import com.as3dmod.core.MeshProxy;
	
	import flash.geom.Vector3D;		

	public class Sandy3dMesh extends MeshProxy {
		
		private var shp:Shape3D;
		
		public function Sandy3dMesh() {	
		}
		
		override public function setMesh(mesh:*):void {
			shp = mesh as Shape3D;
			
			var vs:Array = shp.geometry.aVertex;
			var vc:int = vs.length;
			
			for (var i:int = 0; i < vc; i++) {
				var nv:Sandy3dVertex = new Sandy3dVertex();
				nv.setVertex(vs[i] as Vertex);
				vertices.push(nv);
			}
		}
		
		override public function updateMeshPosition(p:Vector3D):void {
			shp.x += p.x;
			shp.y += p.y;
			shp.z += p.z;
		}
	}
}