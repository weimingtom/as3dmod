package com.as3dmod.plugins.fp10 {
	import com.as3dmod.core.MeshProxy;
	import com.as3dmod.core.VertexProxy;
	import com.as3dmod.plugins.Library3d;	

	/**
	 * @author bartekd
	 */
	public class LibrarySimple extends Library3d {
		
		private var m:MeshProxy;
		private var v:VertexProxy;
		
		public function LibrarySimple() {
			m = new SimpleMesh();
			v = new SimpleVertex();
		}
		
		override public function get id():String {
			return "simple";
		}
		
		override public function get meshClass():String {
			return "com.as3dmod.plugins.fp10.SimpleMesh";
		}
		
		override public function get vertexClass():String {
			return "com.as3dmod.plugins.fp10.SimpleVertex";
		}
	}
}
