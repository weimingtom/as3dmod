package com.as3dmod.modifiers {
	import com.as3dmod.IModifier;
	import com.as3dmod.core.Modifier;
	import com.as3dmod.core.VertexProxy;
	
	import flash.geom.Vector3D;	

	/**
	 * 	<b>Pivot modifier.</b> Allows to move the pivot point of a 3D mesh. 
	 * 	<br>
	 * 	<br>The pivot point will be moved by the amount specified by the pivot vector.
	 * 	<br>Common use case is to set the values of the pivot vector, add it to the modifier stack
	 * 	and collapse the stack. This way the pivot point will be moved and the modifier discarded. The
	 * 	same stack can be later resused for other modifiers. 
	 * 	<br>
	 * 	<br>It is also possible to animtate the pivot vector propeties.
	 * 
	 * 	@version 1.0
	 * 	@author Bartek Drozdz
	 */
	public class Pivot extends Modifier implements IModifier {

		public var pivot:Vector3D;

		public function Pivot(x:Number=0, y:Number=0, z:Number=0) {
			this.pivot = new Vector3D(x, y, z);
		}
		
		/**
		 * Sets the values of the pivot vector so that the pivot point of the mesh will be moved to it's center.
		 */
		public function setMeshCenter():void {
			var vx:Number = -(mod.minX + mod.width / 2);			var vy:Number = -(mod.minY + mod.height / 2);			var vz:Number = -(mod.minZ + mod.depth / 2);
			pivot = new Vector3D(vx, vy, vz);
		}

		public function apply():void {
			var vs:Vector.<VertexProxy> = mod.getVertices();
			var vc:int = vs.length;

			for (var i:int = 0; i < vc; i++) {
				var v:VertexProxy = vs[i] as VertexProxy;
				v.vector = v.vector.add(pivot);
			}
			
			var npivot:Vector3D = pivot.clone();
			npivot.negate();
			mod.updateMeshPosition(npivot);
		}
	}
}