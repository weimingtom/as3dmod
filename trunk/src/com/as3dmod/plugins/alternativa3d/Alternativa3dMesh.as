﻿package com.as3dmod.plugins.alternativa3d {
	
	import alternativa.engine3d.core.Mesh;
	import alternativa.engine3d.core.Vertex;
	import alternativa.types.Set;
	import com.as3dmod.core.MeshProxy;
	import com.carlcalderon.arthropod.Debug;

	public class Alternativa3dMesh extends MeshProxy {
		
		private var awm:Mesh;
		
		public function Alternativa3dMesh() {
			
		}
		
		override public function setMesh(mesh:*):void {
			awm = mesh as Mesh;

			var vs:Set = awm.vertices.toSet();

			while (!vs.isEmpty()) {
				var nv:Alternativa3dVertex = new Alternativa3dVertex();
				nv.setVertex(vs.take());
				vertices.push(nv);
			}
		}
	}
}