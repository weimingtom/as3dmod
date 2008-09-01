package com.as3dmod.modifiers {

	import com.as3dmod.core.Modifier;
	import com.as3dmod.IModifier;
	import com.as3dmod.core.VertexProxy;
	import com.as3dmod.util.ModConstant;
	
	import com.carlcalderon.arthropod.Debug;
	
	public class Bend extends Modifier implements IModifier {
		
		private var frc:Number;
		private var ofs:Number;
		private var cst:int = ModConstant.NONE;
		
		private var maa:int = ModConstant.NONE;
		private var mia:int = ModConstant.NONE;

		public function Bend(f:Number=0, o:Number=.5) {
			force = f;
			offset = o;
		}
		
		public function set force(f:Number):void {
			frc = f;
		}
		
		public function set offset(o:Number):void {
			ofs = o;
			ofs = Math.max(0, o);
			ofs = Math.min(1, o);
		}
		
		public function set constraint(c:int):void {
			cst = c; 
		}
		
		public function get force():Number {
			return frc;
		}
		
		public function get offset():Number {
			return ofs;
		}
		
		public function get constraint():int {
			return cst; 
		}
		
		public function set bendAxis(a:int):void {
			maa = a;
		}
		
		public function set pointAxis(a:int):void {
			mia = a;
		}
		
		public function apply():void {	
			
			if (maa == ModConstant.NONE) maa = mod.maxAxis;
			if (mia == ModConstant.NONE) mia = mod.minAxis;
			
			var pto:Number = mod.getMin(maa);
			var ptd:Number = mod.getMax(maa) - pto;	

			var vs:Array = mod.getVertices();
			var vc:int = vs.length;
			
			//Debug.log("Bend apply " + mia + " / " + maa + " | " + pto + " / " + ptd);
			
			var distance:Number = pto + ptd * offset;
			var radius:Number = ptd / Math.PI / force;
			var angle:Number = Math.PI * 2 * (ptd / (radius * Math.PI * 2));
			
			for (var i:int = 0; i < vc; i++) {
				var v:VertexProxy = vs[i] as VertexProxy;
				
				var p:Number = v.getRatio(maa);
				if (constraint == ModConstant.LEFT && p <= offset) continue;
				if (constraint == ModConstant.RIGHT && p >= offset) continue;
				
				var fa:Number = ((Math.PI / 2) - angle * offset) + (angle * p);
				var op:Number = Math.sin(fa) * (radius + v.getValue(mia)) - radius;
				var ow:Number = distance - Math.cos(fa) * (radius + v.getValue(mia));
				v.setValue(mia, op);
				v.setValue(maa, ow);
			}
		}
	}
}



