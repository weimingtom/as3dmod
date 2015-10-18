![http://www.everyday3d.com/flash/as3dmod/logo_bw.gif](http://www.everyday3d.com/flash/as3dmod/logo_bw.gif)

# AS3Dmod is a cross-engine modifier library in AS3. #

AS3Dmod is a library of modifiers for 3d objects. A modifier is an function used to modify a 3d object. Currently AS3Dmod contains 7 modifiers:

  1. Bend - bends on object along an axis
  1. Noise - deforms an object in a random manner
  1. Skew - skews an object along one or more axes
  1. Taper - http://www.kxcad.net/autodesk/3ds_max/Autodesk_3ds_Max_9_Reference/taper_modifier.html
  1. Bloat - Bloats the mesh by forcing vertices out of specified sphere
  1. Perlin - Generates a perlin noise bitmap and displaces vertices based on the color value of each pixel of the noise map
  1. Twist - twists the mesh around it's center point

AS3Dmod also features an abstract layer and a simple plug-in architecture that allows the modifiers to work with most of the popular Flash 3d engines.

Current version 0.2. Features include:

  1. 7 modifiers as listed above
  1. a framework for creating static and animated modifier stacks
  1. 4 plug-ins for the most popular 3d engines: Pv3d, Away3d, Sandy3d and Alternativa3d
  1. a simple demo for each engine

Documentation (in progress) can be found here: http://www.everydayflash.com/flash/as3dmod/doc/