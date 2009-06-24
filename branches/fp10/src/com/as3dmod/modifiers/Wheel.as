package com.as3dmod.modifiers {
	import com.as3dmod.IModifier;
	import com.as3dmod.core.MeshProxy;
	import com.as3dmod.core.Modifier;
	import com.as3dmod.core.VertexProxy;

	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;

	/**
	 * 	<b>Wheel modifier.</b> Use it with vehicle models for wheels.
	 * 	<br>
	 * 	<p>The usual problem with a 3d wheel in a vahicle is that if it is 
	 * 	supposed to turn (steer) and roll in the same time. So, this code:
	 * 	<br>
	 * 	<br><code><pre>
	 * 	wheel.rotationY = 10; // Steer 10deg to the left
	 * 	wheel.rotationZ +- 5; // Roll with a speed of 5
	 * 	</pre></code><br>
	 * 	This will make the wheel roll incorectly.</p>
	 * 	
	 * 	<p>A usual way to solve this problem is to put the wheel in another DisplayObject3D/Mesh, 
	 * 	turn the parent and roll the child, like that:
	 * 	<br><code><pre>
	 * 	steer.rotationY = 10; // Steer 10deg to the left
	 * 	steer.wheel.rotationZ +- 5; // Roll with a speed of 5
	 * 	</pre></code><br>
	 * 	That will make the wheel behave correctly. But it can be uncomfortanble to apply, especially
	 * 	to imported complex Collada models.</p>
	 * 	
	 * 	<p>The Wheel modifier elegantly solves this problem by doind the proper math in order to steer and roll 
	 * 	a single mesh at the same time. The only thing you need to do is to specify a steer vector and 
	 * 	roll vector - usually it will be 2 of the cardinal axes. The default value is:
	 * 	<ul>
	 * 	<li>steer - along the Y axis / new Vector3(0, 1, 0)</li>	 * 	<li>roll - along the Z axis / new Vector3(0, 0, 1)</li>
	 * 	</ul></p>
	 * 	
	 * 	<p>It should work with most car models imported from 3D editors as this is the natural position of a wheel.<br>
	 * 	<i>Please note, that Papervision primitive cylinder, which may also be used as wheel, will require different axes
	 * 	(Y for roll and Z or X for steer).</i></p>
	 * 	
	 * 	@version 1.0
	 * 	@author Bartek Drozdz
	 */
	public class Wheel extends Modifier implements IModifier {

		public var speed:Number;		public var turn:Number;

		private var roll:Number;		private var _radius:Number;
		
		public var steerVector:Vector3D = new Vector3D(0, 1, 0);		public var rollVector:Vector3D = new Vector3D(0, 0, 1);

		public function Wheel() {
			speed = 0;
			turn = 0;
			roll = 0;
		}

		override public function setModifiable(mod:MeshProxy):void {
			super.setModifiable(mod);
			_radius = mod.width / 2;
		}		public function apply():void {
			roll += speed;

			var ms:Matrix3D = new Matrix3D();
			var mt:Matrix3D = new Matrix3D();
			
			if(turn != 0) {
				mt.appendRotation(turn / Math.PI * 180, steerVector);
				var rv:Vector3D = rollVector.clone();
				rv = mt.transformVector(rv);
				ms.appendRotation(roll / Math.PI * 180, rv);
			} else {
				ms.appendRotation(roll / Math.PI * 180, rollVector);
			}
			
			var vs:Vector.<VertexProxy> = mod.getVertices();
			var vc:int = vs.length;
			for (var i:int = 0;i < vc; i++) {
				var v:VertexProxy = vs[i] as VertexProxy;
				var c:Vector3D = v.vector.clone();
				if(turn != 0) c = mt.transformVector(c);				c = ms.transformVector(c);
				v.x = c.x;				v.y = c.y;				v.z = c.z;
			}
			
//			SosLog.info(c.toString());
		}

		public function get step():Number {
			return _radius * speed / Math.PI;
		}

		public function get perimeter():Number {
			return _radius * 2 * Math.PI;
		}
		
		public function get radius():Number {
			return _radius;
		}	}
}
