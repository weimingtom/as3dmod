package com.as3dmod.components.common {
	import flash.display.TriangleCulling;
	import com.as3dmod.util.Log;

	import flash.display.Graphics;
	import flash.geom.Vector3D;

	/**
	 * @author bartekd
	 */
	public class Renderer {
		
		public static function render(canvas:Graphics, object3d:Renderable, projection:Projection):void {
			
			
			canvas.clear();
//			canvas.lineStyle(1, 0xffffff);

			var vertices3d:Vector.<Vector3D> = object3d.getRenderVertices();
			var vl:int = vertices3d.length;
			var vertices:Vector.<Number> = new Vector.<Number>();
			var ruv:Vector.<Number> = object3d.getUVTs();			var uvt:Vector.<Number> = new Vector.<Number>();
			
			for (var i:int = 0, k:int = 0; i < vl; i++, k+=2) {
				var v:Vector3D = vertices3d[i].clone();
				projection.projectVector(v);
				vertices.push(v.x, v.y);
				uvt.push(ruv[k], ruv[k+1], v.w);
			}

			canvas.beginBitmapFill(object3d.getMaterial(), null, true, true);
			canvas.drawTriangles(vertices, null, uvt, TriangleCulling.NEGATIVE);
			canvas.beginBitmapFill(object3d.getBackMaterial(), null, true, true);			canvas.drawTriangles(vertices, null, uvt, TriangleCulling.POSITIVE);
			canvas.endFill();
		}
	}
}
