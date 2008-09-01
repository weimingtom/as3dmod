package  {

	import com.as3dmod.modifiers.Perlin;
	import com.as3dmod.ModifierStack;
	import com.as3dmod.util.Phase;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import com.as3dmod.modifiers.Bend;
	import com.as3dmod.modifiers.Noise;
	import com.as3dmod.util.ModConstant;
	
	import com.carlcalderon.arthropod.Debug;
	
	public class DemoBase extends Sprite {

		private var demo:Sprite;
		
		private var bone:Bend;
		private var bonePhase:Phase;
		
		private var btwo:Bend;
		private var btwoPhase:Phase;
		
		private var n:Noise;
		private var nph:Phase;
		
		private var p:Perlin;
		
		public function DemoBase() {
			stage.quality = StageQuality.LOW;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			Debug.clear();
			
			demo = new Pv3dDemo(this);
			//demo = new Away3dDemo(this);
			//demo = new Sandy3dDemo(this);
			//demo = new Alternativa3dDemo(this);
			addChild(demo);
		}
		
		public function setupStack(m:ModifierStack):void {
			p = new Perlin();
			m.addModifier(p);
			
			bone = new Bend(0, .7);
			bone.constraint = ModConstant.LEFT;
			bonePhase = new Phase();
			m.addModifier(bone);
			
			btwo = new Bend(0, .3);
			btwo.constraint = ModConstant.RIGHT;
			btwoPhase = new Phase();
			m.addModifier(btwo);
			
			n = new Noise();
			n.constraintAxes(ModConstant.X | ModConstant.Y); // alternativa / pv3d
			//n.constraintAxes(ModConstant.X | ModConstant.Z); // away
			//n.constraintAxes(ModConstant.Y | ModConstant.X); // sandy
			n.setFalloff();
			nph = new Phase();
			//m.addModifier(n);
		}
		
		public function onRender():void {
			bonePhase.value += 0.05;
			bone.force = bonePhase.phasedValue * 2;
			
			btwoPhase.value -= 0.02;
			btwo.force = btwoPhase.phasedValue * 2;
			
			nph.value += 0.04;
			n.force = nph.phasedValue * 20;
		}
	}	
}















