package com.as3dmod.util {
	import flash.geom.Vector3D;	
	
	/**
	 * @author bartekd
	 */
	public class Math3D {
		
		public static function multiplyVectors(a:Vector3D, b:Vector3D):Vector3D {
			return new Vector3D(a.x * b.x, a.y * b.y, a.z * b.z);
		}
		
		public static function setVectorMagnitude(v:Vector3D, m:Number):void {
			v.normalize(); 
			v.x *= m; 
			v.y *= m; 
			v.z *= m;
        }
	}
}
