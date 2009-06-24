package com.as3dmod.components {

	import com.as3dmod.components.util.Document;
	/**
	 * @author bartekd
	 */
	public class DoubleDeckerDemo extends Document {
		
		[Embed (source="assets/sculpture.jpg")]
		private var Sculpture:Class;
		
		[Embed (source="assets/sculpture_description.jpg")]
		private var SculptureDesc:Class;
		
		private var udemo:DoubleDecker;
		
		override protected function launch():void { 
			udemo = new DoubleDecker(new Sculpture(), new SculptureDesc());
			udemo.x = 100;			udemo.y = 50;
			addChild(udemo);
		}
	}
}
