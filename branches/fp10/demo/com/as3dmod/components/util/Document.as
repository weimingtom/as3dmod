package com.as3dmod.components.util {
	import flash.events.Event;	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;	

	/**
	 * @author bartekd
	 */
	public class Document extends Sprite {
		protected var wHalf:Number;
		protected var hHalf:Number;

		public function Document() {
			stage.addEventListener(Event.RESIZE, prelaunch);
			setup();
		}
		
		protected function setup():void {
			stage.quality = StageQuality.MEDIUM;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.showDefaultContextMenu = false;
			stage.stageFocusRect = false;
		}

		private function prelaunch(event:Event):void {
			if(stage.stageWidth != 0) {
				wHalf = stage.stageWidth / 2;
				hHalf = stage.stageHeight / 2;
				stage.removeEventListener(Event.RESIZE, prelaunch);				stage.addEventListener(Event.RESIZE, onResize);
				launch();
			}
		}
		
		protected function onResize(event:Event):void {
			wHalf = stage.stageWidth / 2;
			hHalf = stage.stageHeight / 2;
		}

		protected function launch():void {
			
		}
	}
}
