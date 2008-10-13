package {	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	
	import com.as3dmod.ModifierStack;
	import com.as3dmod.modifiers.Paper;
	import com.as3dmod.plugins.pv3d.LibraryPv3d;		
	/**	 * @author Bartek Drozdz	 */	public class PaperBendDemo extends BasicView {		private var plane:Plane;		private var stack:ModifierStack;		private var paper:Paper;		public function PaperBendDemo() {			stage.quality = StageQuality.LOW;			stage.scaleMode = StageScaleMode.NO_SCALE;			stage.align = StageAlign.TOP_LEFT;			stage.showDefaultContextMenu = false;			stage.stageFocusRect = false;						super(800, 600, true, false, CameraType.TARGET);						var w:WireframeMaterial = new WireframeMaterial();			w.doubleSided = true;			plane = new Plane(w, 1000, 600, 24, 16);			scene.addChild(plane);						plane.rotationX = 60;			plane.rotationY = 20;						stack = new ModifierStack(new LibraryPv3d(), plane);			paper = new Paper(0, 0.5);//			paper.constraint = ModConstant.LEFT;			stack.addModifier(paper);						camera.lookAt(plane);						startRendering();						stage.addEventListener(MouseEvent.MOUSE_WHEEL, onWheel);		}				private function onWheel(event:MouseEvent):void {			plane.rotationY += event.delta;		}		protected override function onRenderTick(event:Event = null):void {			var f:Number = mouseX / stage.stageWidth * 2;			paper.force = f;			stack.apply();			super.onRenderTick(event);		}	}}