# The AS3Dmod Tutorial #



## Introduction ##

AS3Dmod is a cross-engine modifier library for creating 3d animations in Flash and AS3.

To create 3d animations using AS3Dmod you will need the following:

  * **An Actionscript3 editor:** [FlashDevelop](http://www.flashdevelop.org/community/), [FDT](http://fdt.powerflasher.com/) or [FlexBuilder](http://www.adobe.com/products/flex/). The Flash IDE is not recommended. If you don't have any favorite editor use [FlashDevelop](http://www.flashdevelop.org/community/) which is available for free.

  * **A Flash 3D engine:** AS3Dmod currently works with [Papervision3d](http://blog.papervision3d.org), [Away3d](http://www.away3d.com), [Sandy3d](http://www.sandy3d.com) and [Alternativa3d](http://alternativaplatform.com/en/). This tutorial features examples in Papervision3d. Whichever you choose, I recommend using the latest versions from SVN repositories.

  * **AS3Dmod library:** You must use the latest version from SVN [available here](http://code.google.com/p/as3dmod/source/browse/trunk).

  * **Tweener:** We will use [Tweener](http://code.google.com/p/tweener/) in the animation examples, although any other AS3 tweening library can also be integrated with AS3Dmod.

## 1. Setting up the workspace ##

As mentioned above, this tutorial assumes that you use Papervision3D. If you intend to use AS3Dmod with other supported engines, you will need to adapt the code shown below. However, the rules apply the same way to any engine, so this tutorial is still valid.

To start with, create a project in your AS3 editor and make sure you have the Papervision3D classes as well as AS3Dmod classes in your classpath. To make things easier, we will extend the class `BasicView` to create a 3d scene to work on.

`BasicView` is a class that greatly facilitates working with Papervision3D. It's great for all demos/example/tutorials etc, and we will be using it in this tutorial. Read more about [here](http://pv3d.org/2008/12/06/what-is-basicview/).

Our starting point is a simple implementation of `BasicView` with all the necessary imports as well as some basic setup:

```
package com.as3dmod.tutorial {
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	
	import flash.events.Event;	

	public class AS3DmodTutorial extends BasicView {

		private var plane:Plane;

		public function AS3DmodTutorial() {
			super(800, 600, true, false, CameraType.FREE);
			var mat:WireframeMaterial = new WireframeMaterial();
			mat.doubleSided = true;
			plane = new Plane(mat, 300, 300, 10, 10);
			plane.rotationX = 45;
			plane.rotationY = 45;
			scene.addChild(plane);
			startRendering();
		}
		
		protected override function onRenderTick(event:Event = null):void {
			super.onRenderTick(event);
		}
	}
}
```

The beauty of `BasicView` is that it does all the job of creating the 3d environment for us. The only thing we need to do is to create a plane to which we will later apply the modifiers. The plane is rotated on the X and Y axes a bit to give some perspective. Here's what you should see after compiling this example:

![http://www.everydayflash.com/flash/as3dmod/tutorial/base.gif](http://www.everydayflash.com/flash/as3dmod/tutorial/base.gif)

The `onRenderTick` function is called on each frame before the scene is rendered - another thing `BasicView` does for us. Now it contains only the necessary call to the method in the base class, but we will use it to animate the modifier properties later on.

## 2. Creating modifier stack ##

The first step with AS3Dmod is to create a modifier stack. The modifier stack is a link between the 3d object that we want to modify and the modifiers themselves. The modifier stack is a central class of the whole AS3Dmod library. It is important to note that modifiers cannot be applied directly to a 3d object. Everything is handled by the stack. Here's the import:

```
import com.as3dmod.ModifierStack;
```

Since we might want to use the stack in different places in our code, it is always recommended to declare is as class member variable.

```
private var mstack:ModifierStack;
```

After that, in the constructor, before the call to the `startRendering()` we can create the instance of the stack:

```
mstack = new ModifierStack(new LibraryPv3d(), plane);
```

This important line creates the stack by providing it with two arguments. The first one indicates the 3d library we are using, by creating an instance of a special class. Here are the classes that you need to use for each of the supported libraries:

```
com.as3dmod.plugins.sandy3d.LibrarySandy3d;	
com.as3dmod.plugins.alternativa3d.LibraryAlternativa3d;	
com.as3dmod.plugins.away3d.LibraryAway3d;	
com.as3dmod.plugins.pv3d.LibraryPv3d;
```

Just creating the instance of the right class (like shown above) is enough. You do not need to care about anything 3d-engine-related from this point on. Just use the modifiers.

The second argument is the 3d object that the modifiers will be applied to. We pass the plane created before. AS3Dmod works with any 3d object, including all the primitives (planes, cubes, spheres, etc) as well as with different imported types like Collada DAE or Wavefront OBJ (available in Away3d).

This goes beyond the scope of this tutorial, but for now just note that, if you want to apply the modifiers to Collada objects, you need to make sure you pass as argument the object that holds the geometry data (typically a child of the root object in a Collada file).

**The modifier stack does not work with nested 3d objects, it always expects that the 3d object passed as argument is the object that holds all the geometry and if it has any children - they will be ignored.** This might change in future versions, but now this is how things work.

## 3. Creating modifiers ##

Now, the fun part begins! Let's start with a simple noise. In the imports section add the following:

```
import com.as3dmod.modifiers.Noise;
```

Now, immediately after you created the modifier stack, add the following lines:

```
var noise:Noise = new Noise(20);
mstack.addModifier(noise);
mstack.apply();
```

Compile your class, and you will see that the plane is randomly displaced - this is what the Noise modifier does.

![http://www.everydayflash.com/flash/as3dmod/tutorial/noise.gif](http://www.everydayflash.com/flash/as3dmod/tutorial/noise.gif)

Let's examine the code. In the first line you create a modifier: Noise in this case. The first argument indicates the force of the effect. 0 means no deformation at all, while a value somewhere around a 200 (in this case) creates a very strong deformation. Try to experiment with it.

Once the modifier is created it needs to be added the the stack. That is the only way it can be applied to the 3d object.

This is good place to note one important feature: **It DOES matter in which order the modifiers are added to the stack.**

The first ones added will be the first ones applied, and each modifier is applied to an object already transformed by any modifiers that were applied before him. Sometimes the difference won't be important, but in other cases changing the order the modifiers are added to the stack can completely change the final visual effect. It is always good to experiment with that, because in most cases the results are hard to predict. Modifiers work exactly like filters in Photoshop.

The last line in the code above has a key importance:

```
mstack.apply();
```

It tells the stack to apply ALL the modifiers to the 3d object. What is important to understand here is that the modifiers are applied and deform the object but its original geometry (i.e. shape) is conserved. Whenever `apply()` is invoked again all the modifiers are applied on the original geometry of the object again. In other words: calling apply multiple times gives end up always with the final result... unless the properties in one or more modifier change in the meantime. Which brings us the the subject of animation.

## 4. Animating modifiers ##

Obviously, modifiers are most useful (and cool) when used to animate 3d objects. In order to do this we need to change properties of the modifier in a regular time interval, and after each change call the `apply()` method. Typically in Flash the best place to do this is on each frame just before calling the rendering function of the engine.

The Noise modifier that we added before is very simple and not very useful for animation purposes. Let's remove it and add another one instead:

```
import com.as3dmod.modifiers.Perlin;

[...]

var perlin:Perlin = new Perlin(2);
mstack.addModifier(perlin);
```

We do not call the `apply()` method here anymore. Instead we will call it on every frame. In the `BasicView` class, the the place where it should be done is the `onRenderTick` method already mentioned above:

```
protected override function onRenderTick(event:Event = null):void {
	mstack.apply();
	super.onRenderTick(event);
}
```

If you run the code you should see the plane waving gently as if it was a cloth exposed to  wind. This is the effect of the Perlin modifier. The animation is made possible because `apply()` is called on each frame.

![http://www.everydayflash.com/flash/as3dmod/tutorial/perlin.gif](http://www.everydayflash.com/flash/as3dmod/tutorial/perlin.gif)

If you were reading carefully, you are thinking now that something is missing here: we call `apply()` over and over again, but we never modify any parameter of the modifier itself. That is true! The animation is made possible because Perlin is a bit special modifier. It animates itself, by changing its internal properties each time after `apply()` is invoked.

The other modifiers do not work like this, and their properties need to be explicitly updated in the code. Let's examine probably the most popular one: Bend.

## 5. Changing modifier properties ##

Let's start by removing the Perlin modifier and adding Bend instead. But this time we will need to define it as a class member variable. So, add this before the constructor together with the rest of the variables:

```
import com.as3dmod.modifiers.Bend;

[...]

private var bend:Bend;
```

Now we can define the modifier itself. In the same place where you added the Perlin modifier before, now add this:

```
bend = new Bend(0, 0.5);
mstack.addModifier(bend);
```

The two arguments in the constructor are: the force and the offset. Setting the force to 0 means no bend at all - this is what we want to start with. The other meaningful values of bend force are: 1 for a 180 degrees bending for 2 for 360. If you know radians you can notice that the force is actually the value of the bend in radians divided by PI.

The second argument, called offset, indicates the place in the objects geometry where the bending will start. 0 is the top/left edge of the object and 1 is its bottom/right edge. 0.5 will start the bend in the middle point of the geometry - this is what we set here. It is also the default value, and it could be omitted.

Now, let's move to the `onRenderTick` method. Just before the `mstack.apply()` line add the following:

```
bend.force += .01;
```

At each frame we are incrementing the the force of the bend a little bit. If you run the example now you can see the the plane bending slowly. At the point where `force = 2` it will start to roll on itself (that usually doesn't look good, especially with a color/bitmap material).

![http://www.everydayflash.com/flash/as3dmod/tutorial/bend.gif](http://www.everydayflash.com/flash/as3dmod/tutorial/bend.gif)

## 6. Animating with Phase ##

You can always write your own code to control the properties of any modifier. There are however two simple ways to animate them without to much hassle. The first one is the Phase class. To use it let's import it and create a new class member variable and initialize the instance:

```
import com.as3dmod.util.Phase;

[...]

private var phase:Phase;

[...]

// Anywhere in the constructor
phase = new Phase();
```

Phase is a class that lets you create simple waveform animation. It is very basic and is no match to other tweening solutions available, but it's very useful in many cases, and that is why it is included in the API.

The way it works is that it holds a value and returns a sine of this values. If you keep incrementing the value, you will get back values in range -1 to 1 in form of a wave - going up and down. If you ever heard the term 'sine wave' - that's what it is.

Now in `onRenderTick` instead of incrementing the force of the bend, add the following code:

```
phase.value += .05;
bend.force = phase.phasedValue;
```

If you run the example now, the plane should bend back and forth in a movement that looks a little bit like a flight of a large bird. Never seen a square bird? Huh!

![http://www.everydayflash.com/flash/as3dmod/tutorial/bendphase.gif](http://www.everydayflash.com/flash/as3dmod/tutorial/bendphase.gif)

The `phasedValue` will always oscillate between -1 and 1. Whenever you need different range - multiply this value or add something to it.

## 7. Animating with Tweener ##

[Tweener](http://code.google.com/p/tweener/) is a popular library used in Actionscript animation. It is very easy to understand and to use and comes with some quite powerful features. Fortunately integrating it with AS3Dmod is a piece of cake.

To use Tweener, you need first of all remove the code that animates the force value in `onRenderTick`. Let's do it by simply commenting it out:

```
// phase.value += .05;
// bend.force = phase.phasedValue;
```

Now lets add two new functions:

```
private function tweenA():void {
	Tweener.addTween(bend, {force:1, time:2, transition:"easeInOutElastic", onComplete:tweenB});
}
		
private function tweenB():void {
	Tweener.addTween(bend, {force:-1, time:2, transition:"easeInOutElastic", onComplete:tweenA});
}
```

Discussing Tweener in depth is not it the scope of this tutorial, but there's a very good documentation you can refer to http://hosted.zeh.com.br/tweener/docs/en-us/.

In brief, what those to functions do, is that they initiate animations of the bend force parameter. By using `onComplete` parameter we make sure that whenever `tweenA` ends it calls `tweenB` and vice-versa. Thanks to this the animation is looped. The only thing we need now is to start the tween for the first time. To do this just add a method call at the very end of the constructor:

```
tweenA();
```

There you go! The plane should now bend with an elastic movement back and forth.

## 8. Collapsing the modifier stack ##

Now that you know all the basics of using the modifier stack as well as adding and animating modifiers, I'd like to cover one last feature: collapsing the stack.

Collapsing the stack means applying all the modifiers and freezing the geometry. This is particularly useful if you want to apply one modifier once, and then add more modifiers later that will be animated.

Go to the place where the stack and all the modifiers are initiated and add the Noise modifier:

```
mstack = new ModifierStack(new LibraryPv3d(), plane);

var noise:Noise = new Noise(20);
mstack.addModifier(noise);

bend = new Bend(0, 0.5);
mstack.addModifier(bend);
```

If you run the code now, you will notice that the plane shakes like crazy. That is because  at each frame, when `apply()` is called both Noise and Bend are applied. Noise adds a random displacement to each vertex of the plane at each frame - hence the shaking. Now try to collapse the stack just after the Noise modifier was added:

```
mstack.addModifier(noise);
mstack.collapse();
bend = new Bend(0, 0.5);
```

The plane should now have a crumpled look and the bend should be working exactly the same as before.

## 9. Feedback ##

I hope this tutorial will help you understand the basics of AS3Dmod. Remember that the [API Docs](http://www.everydayflash.com/flash/as3dmod/doc/) are also available.

**If you find any inconsistencies, errors or typos in the tutorial, please let me know**. You can leave a comment below or email me to bartek at everydayflash dot com.