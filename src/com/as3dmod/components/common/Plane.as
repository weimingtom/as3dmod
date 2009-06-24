package com.as3dmod.components.common {
	import com.as3dmod.util.Log;

	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Vector3D;

	/**
	 * @author bartekd
	 */
	public class Plane extends Sprite implements Renderable {

		private var material:Material;

		private var faces:Vector.<Face>;
		private var vertices:Vector.<Vector3D>;
		private var backMaterial:BitmapData;

		public function Plane(material:Material, segmentsW:int = 1, segmentsH:int = 1) {
			
			this.material = material;
			this.backMaterial = material.clone();
			this.backMaterial.fillRect(backMaterial.rect, 0xff808080);
			
			var cols:int = Math.max(1, segmentsW);			var rows:int = Math.max(1, segmentsH);
			
			var pwidth:Number = material.width;			var pheight:Number = material.height;
			
			var fwidth:Number = pwidth / cols;			var fheight:Number = pheight / cols;
			
			var fu:Number = 1 / cols;
			var fv:Number = 1 / rows;
			
			faces = new Vector.<Face>();
			vertices = new Vector.<Vector3D>();
			
			for (var i:int = 0;i < rows; i++) {
				for (var j:int = 0;j < cols; j++) {
					var f:Face = new Face();
					f.a = new Vector3D(j * fwidth, i * fheight, 0);					f.b = new Vector3D((j + 1) * fwidth, i * fheight, 0);					f.c = new Vector3D((j + 1) * fwidth, (i + 1) * fheight, 0);					f.d = new Vector3D(j * fwidth, (i + 1) * fheight, 0);
					f.auv = new UV(j * fu, i * fv);					f.buv = new UV((j + 1) * fu, i * fv);					f.cuv = new UV((j + 1) * fu, (i + 1) * fv);					f.duv = new UV(j * fu, (i + 1) * fv);
					faces.push(f);
				}
			}
		}

		public function getMaterial():BitmapData {
			return material;
		}
		
		public function getBackMaterial():BitmapData {
			return backMaterial;
		}

		public function getVertices():Vector.<Vector3D> {
			var rvertices:Vector.<Vector3D> = new Vector.<Vector3D>();
			for each (var f:Face in faces) {
				rvertices = rvertices.concat(f.getVertices());
			}
			return rvertices;
		}
		
		public function getRenderVertices():Vector.<Vector3D> {
			var rvertices:Vector.<Vector3D> = new Vector.<Vector3D>();
			for each (var f:Face in faces) {
				rvertices = rvertices.concat(f.getRenderVertices());
			}
			return rvertices;
		}

		public function getUVTs():Vector.<Number> {
			var ruvs:Vector.<Number> = new Vector.<Number>();
			for each (var f:Face in faces) {
				ruvs = ruvs.concat(f.getUVS());
			}
			return ruvs;
		}
	}
}
