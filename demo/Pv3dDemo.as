package {
	
	import com.as3dmod.modifiers.Bend;
	import com.as3dmod.modifiers.Noise;
	import com.as3dmod.ModifierStack;
	
	import com.as3dmod.plugins.pv3d.LibraryPv3d;
	import org.papervision3d.core.proto.MaterialObject3D;
	import org.papervision3d.materials.BitmapWireframeMaterial;
	import org.papervision3d.materials.ColorMaterial;
	import org.papervision3d.materials.special.CompositeMaterial;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	import flash.events.Event;
	import com.carlcalderon.arthropod.Debug;
	import com.as3dmod.util.ModConstant;

	public class Pv3dDemo extends BasicView {
		
		private var c:DisplayObject3D;
		private var m:ModifierStack;
		private var base:DemoBase;
		public function Pv3dDemo(base:DemoBase) {
			this.base = base;
			var mt:CompositeMaterial = new CompositeMaterial();
			mt.addMaterial(new ColorMaterial(0x27590e));
			mt.addMaterial(new WireframeMaterial(0x49a51c));
			mt.doubleSided = true;
			
			c = new Plane(mt, 1200, 500, 24, 10);
			c.rotationX = 60;
			c.rotationY = 45;
			scene.addChild(c);
			
			m = new ModifierStack(new LibraryPv3d(), c);
			base.setupStack(m);
			
			
			startRendering();
		}
		
		protected override function onRenderTick(event:Event = null):void {
			base.onRender();
			m.apply();
			super.onRenderTick(event);
		}
	}
}





