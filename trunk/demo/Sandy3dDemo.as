﻿package  {

	import com.as3dmod.plugins.sandy3d.LibrarySandy3d;
	import flash.display.Sprite;
	import sandy.core.Scene3D;
	import sandy.core.scenegraph.Camera3D;
	import sandy.core.scenegraph.Group;
	import sandy.core.scenegraph.Shape3D;
	import sandy.materials.Appearance;
	import sandy.materials.attributes.LineAttributes;
	import sandy.materials.attributes.MaterialAttributes;
	import sandy.materials.ColorMaterial;
	import sandy.materials.Material;
	import sandy.materials.WireFrameMaterial;
	import sandy.primitive.Plane3D;
	import sandy.primitive.Sphere;
	import flash.events.Event;
	import com.as3dmod.ModifierStack;
	import com.as3dmod.modifiers.Noise;
	import com.as3dmod.modifiers.Bend;
	import com.as3dmod.util.ModConstant;
	import flash.display.StageQuality;
 
	public class Sandy3dDemo extends Sprite {
		
		private var scene:Scene3D;
		private var c:Shape3D;
		private var m:ModifierStack;
		private var base:DemoBase;
		
		public function Sandy3dDemo(base:DemoBase) {
			this.base = base;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			scene = new Scene3D( "myScene", this, new Camera3D( stage.stageWidth, stage.stageHeight ), new Group("root") );
			
			var materialAttr:MaterialAttributes = new MaterialAttributes(new LineAttributes(1, 0x49a51c, 1));
			var material:Material = new ColorMaterial( 0x27590e, 1, materialAttr );
			
			var materialAttrb:MaterialAttributes = new MaterialAttributes(new LineAttributes(1, 0x49a51c, 1));
			var materialb:Material = new ColorMaterial( 0x27590e, 1, materialAttrb );
			
			var app:Appearance = new Appearance(material, materialb);
			
			c = new Plane3D("plane", 600, 250, 10, 24);
			c.rotateX = 70;
			c.z = 400;
			c.appearance = app;
			scene.root.addChild(c);
			
			m = new ModifierStack(new LibrarySandy3d(), c);
			
			base.setupStack(m);
			
			
			
			addEventListener(Event.ENTER_FRAME, render);
		}
		
		private function render(event:Event):void {
			base.onRender();
			m.apply();
			//c.rotateX += 2;
			c.rotateY += 2;
			scene.render();
		}
	}
}