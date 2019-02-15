# corona-magnifier
A module for [Corona](https://www.coronalabs.com) that creates a virtual "magnifying glass" object that magnifies all objects beneath it on the canvas

## How to use:

1. Add `magnifier.lua` and `mask.png` (or use your own [valid mask file](https://docs.coronalabs.com/guide/media/imageMask/index.html)) to your Corona project.
2. Update `magnifier.lua` as needed to reflect the path of your mask file. By default it looks for `mask.png` in the project root, but you can update the path by modifying the `mask_file_path` variable on line 4 of `magnifier.lua`.
3. The module needs to know the width and height of your mask image. It assumes that these values are both 2048, but you can customize those values on line 5 of `magnifier.lua` if need be.
3. Require the module:  
`local magnifier = require('magnifier')`
4. Create a new magnifier object by calling `magnifier.new()`
5. That's it! You have created a display object that will automatically show a magnified image of the portion of the Corona [StageObject](https://docs.coronalabs.com/api/type/StageObject/index.html) beneath it.

## Customizing Your Magnifier Object
Calling `magnifier.new()` with no arguments will return a magnifier object, but by passing in a parameters table, you can change the appearance of the magnifier. The parameters table accepts three key/value pairs:  
- **diameter**: a number representing the diameter of the circular object. Defaults to 1/3 the device screen width.  
- **zoom**: a number representing the zoom factor of the magnifier object. Defaults to `1.2`.  
- **bulge**: a number representing the bulge factor, creating the impression of a rounded glass lens. Defaults to `1` (no bulge).  
*Note: applying a bulge may cause slowdown on less-capable devices. Use with caution.*

## Example Usage:
```lua
local magnifier = require('magnifier')

local lens = magnifier.new({
  diameter = 200,
  zoom = 1.4,
  bulge = 1.15,
})
```

## Sample Project
Load the `sample_project` subdirectory of this repository in the Corona Simulator to view a sample project. Or you can watch this video demo on YouTube:  

<a href="http://www.youtube.com/watch?feature=player_embedded&v=1gxV_-hKxjM" target="_blank"><img src="http://img.youtube.com/vi/1gxV_-hKxjM/0.jpg" width="480" height="360" border="0" /></a>
