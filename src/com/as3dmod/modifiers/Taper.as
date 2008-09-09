package com.as3dmod.modifiers {
	import com.as3dmod.IModifier;
	import com.as3dmod.core.Modifier;
	import com.as3dmod.core.VertexProxy;
	import com.as3dmod.util.XMath;		

	public class Taper extends Modifier implements IModifier
	{
		private var frc:Number;		private var pow:Number;
		
		private var start:Number = 0;
		private var end:Number = 1;
		
		/**
		 * 	Taper modifier. 
		 * 	
		 * 	The taper modifier displaces the vertices on two 
		 * 	axes proportionally to their position on the third axis.
		 * 	
		 * 	
		 */
		public function Taper(f:Number) {
			frc = f;
			pow = 1;
		}
		
		public function setFalloff(start:Number=0, end:Number=1):void {
			this.start = start;
			this.end = end;
		}
		
		public function set force(value:Number):void {
			frc = value;
		}
		
		public function get force():Number {
			return frc;
		}
		
		public function get power():Number { 
			return pow; 
		}
		
		public function set power(value:Number):void { 
			pow = value; 
		}

		public function apply():void {
			var vs:Array = mod.getVertices();
			var vc:int = vs.length;
			
			for (var i:int = 0; i < vc; i++) {
				var v:VertexProxy = vs[i] as VertexProxy;
				
				var appliedForce:Number = frc;
				var appliedRatio:Number = Math.pow(XMath.normalize(start, end, v.getRatio(mod.maxAxis)), pow);
				var origMin:Number = v.getValue(mod.minAxis);
				var absMin:Number = (origMin != 0) ? origMin / Math.abs(origMin) : 0;
				var offsetMin:Number = origMin + appliedForce * appliedRatio * absMin;
				v.setValue(mod.minAxis, offsetMin);
				
				var origMid:Number = v.getValue(mod.midAxis);
				var absMid:Number = (origMid != 0) ? origMid / Math.abs(origMid) : 0;
				var offsetMid:Number = origMid + appliedForce * appliedRatio * absMid;
				v.setValue(mod.midAxis, offsetMid);
			}
		}
	}
}







