package com.as3dmod.components {
	import com.as3dmod.modifiers.Pivot;
	import com.as3dmod.ModifierStack;
	import com.as3dmod.components.common.Corner;
	import com.as3dmod.components.common.Material;
	import com.as3dmod.components.common.Plane;
	import com.as3dmod.components.common.Projection;
	import com.as3dmod.components.common.Renderer;
	import com.as3dmod.modifiers.Bend;
	import com.as3dmod.plugins.fp10.LibrarySimple;
	import com.as3dmod.util.Log;
	import com.as3dmod.util.ModConstant;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * UnderHood has 4 layers
	 * 1. Link generated on top in the corner of choice (with hover)
	 * 2. Front content
	 * 3. Front content 3d bitmap
	 * 4. Shadow
	 * 5. Back content
	 * 
	 * 
	 * @author bartekd
	 */
	public class DoubleDecker extends Sprite {

		private var opener:Corner;

		private var front:DisplayObject;

		private var front3d:Plane;
		private var frontMaterial:Material;
		private var projection:Projection;

		//		private var shadow:Sprite;

		private var back:DisplayObject;
		private var stack:ModifierStack;
		private var bend:Bend;
		private var cycle:Number = 0;

		public function DoubleDecker(front:DisplayObject, back:DisplayObject) {
			Log.init(this);
			
			this.back = back;
			addChild(back);

			frontMaterial = new Material(front);
			front3d = new Plane(frontMaterial, 10, 10);
			
			stack = new ModifierStack(new LibrarySimple(), front3d.getVertices());
			
			var pivot:Pivot = new Pivot();
			stack.addModifier(pivot);
			pivot.setMeshCenter();
			stack.collapse();
			
			bend = new Bend(0, .6, Math.PI / -6);
			bend.constraint = ModConstant.LEFT;
			stack.addModifier(bend);
			
			addChild(front3d);
			
			
			
			this.front = front;
			//			addChild(front);

			opener = new Corner(Corner.BOTTOM_RIGHT, 90);
			opener.x = front.width;
			opener.y = front.height;
			opener.addEventListener(MouseEvent.CLICK, onOpener);			//			addChild(opener);
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}

		private function onAdded(event:Event):void {
			projection = new Projection(frontMaterial.width / 2, frontMaterial.height / 2);
			addEventListener(Event.ENTER_FRAME, render);
		}

		private function render(event:Event):void {
			
			bend.force = 0.6 * (1 + Math.sin(cycle));
			cycle += 0.05;
			stack.apply();
			Renderer.render(front3d.graphics, front3d, projection);
		}

		private function onOpener(event:MouseEvent):void {
			front.visible = !front.visible;
		}
	}
}
