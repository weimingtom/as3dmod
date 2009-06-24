package com.as3dmod.components.common {
	import flash.display.BitmapData;
	import flash.geom.Vector3D;

	/**
	 * @author bartekd
	 */
	public interface Renderable {

		function getBackMaterial():BitmapData;
		
		function getMaterial():BitmapData;
		
		function getRenderVertices():Vector.<Vector3D>;
		
		function getVertices():Vector.<Vector3D>;
		
		function getUVTs():Vector.<Number>;
	}
}
