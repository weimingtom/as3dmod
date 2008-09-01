package com.as3dmod.core {

	import com.as3dmod.util.ModConstant;
	
	public class Modifier {
		
		protected var mod:MeshProxy;
		
		public function setModifiable(mod:MeshProxy):void {
			this.mod = mod;
		}
		
		public function getVertices():Array {
			return mod.getVertices();
		}
	}
}