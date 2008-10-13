package com.as3dmod.modifiers {
	import flash.geom.Point;
	
	import com.as3dmod.IModifier;
	import com.as3dmod.core.Modifier;
	import com.as3dmod.core.Vector3D;
	import com.as3dmod.core.VertexProxy;
	import com.as3dmod.util.LinearFunction;
	import com.as3dmod.util.ModConstant;		

	/**
	 * 	In progress. Do not use.
	 * 	@author Bartek Drozdz
	 */
	public class Paper extends Modifier implements IModifier {
		
		private var _force:Number;
		private var _offset:Number;
		private var _axis:Vector3D;
		private var cst:int = ModConstant.NONE;

		public function Paper(f:Number=0, o:Number=.5, a:Vector3D=null) {
			_force = f;
			_offset = o;
			_axis = a;
			if(!_axis) _axis = new Vector3D(1,0,0);
		}

		public function set force(f:Number):void {
			_force = f;
		}

		public function set axis(v:Vector3D):void {
			_axis = v;
		}

		public function set constraint(c:int):void {
			cst = c; 
		}
		
		public function get force():Number {
			return _force;
		}
		
		public function get axis():Vector3D {
			return _axis;
		}
		
		public function get constraint():int {
			return cst; 
		}
		
		public function get offset():Number {
			return _offset;
		}
		
		public function set offset(offset:Number):void {
			_offset = offset;
		}

		/**
		 *  Applies the modifier to the mesh
		 */
		public function apply():void {	
			if(force == 0) return;
			
			var mx:int = mod.maxAxis;
			var md:int = mod.midAxis;
			var mn:int = mod.minAxis;
			
			var size:Number = mod.getSize(mx);
			var pointOrigin:Number = mod.getMin(mx);

			var vs:Array = mod.getVertices();
			var vc:int = vs.length;
			

			var foff:LinearFunction = new LinearFunction(new Point(.5, 0), new Point(1, 1));

			for (var i:int = 0; i < vc; i++) {
				var v:VertexProxy = vs[i] as VertexProxy;
				
				var p:Point = new Point(v.getRatio(mx), v.getRatio(md));
				
				var distance:Number = pointOrigin + size * foff.value(p.y);
				var radius:Number = size / Math.PI / force;
				var angle:Number = Math.PI * 2 * (size / (radius * Math.PI * 2));

				var pd:Number = foff.perpendicularDistance(p);
				if(foff.value(p.x) < p.x) pd *= -1;
				
				var fa:Number = Math.PI / 2 - angle * foff.value(p.y) + angle * p.x;
				var op:Number = Math.sin(fa) * radius;
				var ow:Number = Math.cos(fa) * radius;

				v.setValue(mn, op - radius);
				v.setValue(mx, distance - ow);
			}
		}
	}
}


