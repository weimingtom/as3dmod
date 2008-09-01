/**
 * Copyright (c) 2008 Bartek Drozdz (http://www.everydayflash.com)
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 * 
 * Same license applies to every file in this package.  
 */
package com.as3dmod {
	
	import com.as3dmod.IModifier;
	import com.as3dmod.core.MeshProxy;
	import com.as3dmod.plugins.Library3d;
	import com.as3dmod.plugins.PluginFactory;

	public class ModifierStack  {
		
		private var lib3d:Library3d;
		private var baseMesh:MeshProxy;
		private var stack:Array;
		
		public function ModifierStack(lib3d:Library3d, mesh:*) {
			this.lib3d = lib3d;
			baseMesh = PluginFactory.getMeshProxy(lib3d);
			baseMesh.setMesh(mesh);
			baseMesh.analyzeGeometry();
			stack = new Array();
		}
		
		public function get mesh():MeshProxy {
			return baseMesh;
		}
		
		public function addModifier(mod:IModifier):void {
			mod.setModifiable(baseMesh);
			stack.push(mod);
		}
		
		public function apply():void {
			baseMesh.resetGeometry();
			for (var i:int = 0; i < stack.length; i++) {
				(stack[i] as IModifier).apply();
			}
		}
	}
}





















