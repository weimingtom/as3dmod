package com.as3dmod.plugins.sandy3d {
	import com.as3dmod.core.FaceProxy;
	import com.as3dmod.core.MeshProxy;
	import com.as3dmod.core.Vector3;
	
	import sandy.core.data.Vertex;
	import sandy.core.scenegraph.Shape3D;
	
	import flash.utils.Dictionary;
	
	public class Sandy3dMesh extends MeshProxy {
		
		private var shp:Shape3D;
		
		public function Sandy3dMesh() {	
		}
		
		override public function setMesh(mesh:*):void {
			shp = mesh as Shape3D;
			
			var lookUp : Dictionary = new Dictionary(true);
			var vs:Array = shp.geometry.aVertex;
			var ts:Array = shp.aPolygons;
			var vc:int = vs.length;
			var tc:int = ts.length;
			
			for (var i:int = 0; i < vc; i++) {
				var nv:Sandy3dVertex = new Sandy3dVertex();
				nv.setVertex(vs[i] as Vertex);
				vertices.push(nv);
				lookUp[vs[i]] = nv;
			}
			
			for (i = 0; i < tc; i++) {
				var nt:FaceProxy = new FaceProxy();
				
				for (var j : int = 0; j < ts[i].vertices.length; j++) {
					nt.addVertex(lookUp[ts[i].vertices[j]]);
				}
				
				faces.push(nt);
			}
		}
		
		override public function updateMeshPosition(p:Vector3):void {
			shp.x += p.x;
			shp.y += p.y;
			shp.z += p.z;
		}
	}
}