package com.as3dmod.modifiers {
	import com.as3dmod.IModifier;
	import com.as3dmod.core.Modifier;
	import com.as3dmod.core.VertexProxy;	

	public class Taper extends Modifier implements IModifier
	{
		private var frc:Number;
		
		/**
		 * 	Taper modifier. 
		 * 
		 * 	This class is only a dev version for now, with very limited funcionality.
		 */
		public function Taper(f:Number) {
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
				
				var ol:Number = v.getValue(mod.minAxis);
				var od:Number = (ol != 0) ? ol / Math.abs(ol) : 0;
				var vl:Number = ol + Math.abs(force) * v.getRatio(mod.maxAxis) * od;
				v.setValue(mod.minAxis, vl);
			}
		}
	}
}







