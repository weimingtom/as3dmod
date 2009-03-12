package com.as3dmod.plugins.away3d {
	import away3d.core.base.Mesh;
	import away3d.core.base.Vertex;
	
	import com.as3dmod.core.MeshProxy;
	
	import flash.geom.Vector3D;	

	public class Away3dMesh extends MeshProxy {
		
		private var awm:Mesh;
		
		override public function setMesh(mesh:*):void {
			awm = mesh as Mesh;

			var vs:Array = awm.vertices;
			var vc:int = vs.length;
			
			for (var i:int = 0; i < vc; i++) {
				var nv:Away3dVertex = new Away3dVertex();
				nv.setVertex(vs[i] as Vertex);
				vertices.push(nv);
			}
		}
		
		override public function updateMeshPosition(p:Vector3D):void {
			awm.x += p.x;
			awm.y += p.y;
			awm.z += p.z;
		}
	}
}