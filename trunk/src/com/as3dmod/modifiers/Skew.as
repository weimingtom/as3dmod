package com.as3dmod.modifiers {
	import com.as3dmod.IModifier;
	import com.as3dmod.core.Modifier;
	import com.as3dmod.core.VertexProxy;	

	public class Skew extends Modifier implements IModifier
	{
		private var frc:Number;
		
		/**
		 * 	Skew modifier. 
		 * 
		 *  This class is only a dev version for now. 
		 */
		public function Skew(f:Number) {
			f = force;
		}
		
		public function set force(f:Number):void {
			frc = f;
		}
		
		public function get force():Number {
			return frc;
		}
		
		public function apply():void {
			var vs:Array = mod.getVertices();
			var vc:int = vs.length;
			
			for (var i:int = 0; i < vc; i++) {
				var v:VertexProxy = vs[i] as VertexProxy;
				
				var vl:Number = v.getValue(mod.minAxis) + force * v.getRatio(mod.maxAxis);
				v.setValue(mod.minAxis, vl);
			}
		}
	}
}







