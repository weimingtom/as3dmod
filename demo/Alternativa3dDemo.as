package {
	
	import alternativa.engine3d.controllers.CameraController;
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Mesh;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Scene3D;
	import alternativa.engine3d.display.View;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.materials.WireMaterial;
	import alternativa.engine3d.primitives.Box;
	import alternativa.engine3d.primitives.Plane;
	import alternativa.types.Texture;
	import alternativa.utils.FPS;
	import com.as3dmod.plugins.alternativa3d.LibraryAlternativa3d;
	import flash.display.BitmapData;
	import com.as3dmod.util.ModConstant;
	
	import com.as3dmod.ModifierStack;
	import com.as3dmod.modifiers.Noise;
	import com.as3dmod.modifiers.Bend;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	public class Alternativa3dDemo extends Sprite	{
		
		private var scene:Scene3D;
		private var view:View;
		private var camera:Camera3D;
		private var cameraController:CameraController;
		private var c:Mesh;
		private var m:ModifierStack;
		private var base:DemoBase;
		
		public function Alternativa3dDemo(base:DemoBase) {
			this.base = base;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);

			// Creating scene
			scene = new Scene3D();
			scene.root = new Object3D();
			
			c = new Plane(600, 250, 24, 10, true);
			c.cloneMaterialToAllSurfaces(new FillMaterial(0x27590e, 1, "normal", 0));
			scene.root.addChild(c);
			c.rotationX = 90;
			
			m = new ModifierStack(new LibraryAlternativa3d(), c);
			
			base.setupStack(m);
			
			
			
			// Adding camera and view
			camera = new Camera3D();
			camera.x = 0;
			camera.y = 0;
			camera.z = 500;
			scene.root.addChild(camera);
			
			view = new View();
			addChild(view);
			view.camera = camera;

			// Connecting camera controller
			cameraController = new CameraController(stage);
			cameraController.camera = camera;
			cameraController.setDefaultBindings();
			cameraController.checkCollisions = false;
			cameraController.collisionRadius = 20;
			cameraController.lookAt(c.coords);
			cameraController.controlsEnabled = false;

			stage.addEventListener(Event.RESIZE, onResize);
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			onResize(null);
		}
		
		private function onResize(e:Event):void {
			view.width = stage.stageWidth;
			view.height = stage.stageHeight;
		}
		
		private function onEnterFrame(e:Event):void {
			base.onRender();
			m.apply();
			c.rotationY += .02;
			//cameraController.processInput();
			scene.calculate();
		}
	}
}