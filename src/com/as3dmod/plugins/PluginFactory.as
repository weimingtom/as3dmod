package com.as3dmod.plugins {
	
	import com.as3dmod.core.MeshProxy;
	import com.as3dmod.ModifierStack;
	import flash.utils.getDefinitionByName;

	public class PluginFactory {

		public static function getMeshProxy(lib3d:Library3d):MeshProxy {
			var MeshProxyClass:Class = getDefinitionByName(lib3d.meshClass) as Class;
			return new MeshProxyClass();
		}
	}
}