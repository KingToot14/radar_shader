# Radar Shader
https://github.com/KingToot14/radar_shader/assets/46078617/187ba1b5-5791-4830-b651-d3ffc7f803d5

A simple test project for a radar/minimap system with shaders

## Shaders
This example project incldues 3 shaders for the radar:
1. The radar scanner line ([Link](https://godotshaders.com/shader/radar-scanner))
2. The main circle in the radar "blip" ([Link](https://godotshaders.com/shader/radar-blip))
3. The expanding ring around the blips ([Link](https://godotshaders.com/shader/radar-blip-ring))

## How it Works
I think looking around in the demo project will help more than anything, but I will try to explain what's going on:

First of all, in each entity (good guys, bad guys, rat), we have a "blip" object. This object is special in that it isn't supposed to be rendered by the normal viewport, but only by a special viewport designed for the radar. To do this, we use a visibility layer (Notice how only the second layer is selected)\
\
![image](https://github.com/KingToot14/radar_shader/assets/46078617/69f4a2e5-d94f-4bcf-9e5e-5e5c1d6c7391)

### SubViewports
By default, objects use the first layer. However, our blips use the second layer, which allows us to isolate them from other objects. In Godot, we can use SubViewports to create separately rendered content\
\
![image](https://github.com/KingToot14/radar_shader/assets/46078617/693bc7b2-fbcc-48c8-8b53-331ce8292416)

Under normal circumstances, the SubViewport only renders its children, but we can create a workaround for this by setting the `world_2d` value
```gdscript
func _ready():
    var viewport = get_tree().root
    world_2d = viewport.world_2d
```
By attaching this code to the `_ready` function in the 'Blip Viewport', we can render all the content in the root viewport (the default viewport). While we're in this script, we also need to configure the root viewport to NOT render anything on layer two. We can do this with the following code:
```gdscript
    viewport.canvas_cull_mask &= 0b1111111101
```
This code essentially removes the second layer from the main viewport's rendering by setting the second bit of the `canvas_cull_mask` to 0 (disabled)

### ViewportTexture
We're almost done. The last thing we need to do is set up the SubViewport 'Blip Viewport' and have it render to a ViewportTexture. Starting with the Blip Viewport, we need to set its cull mask to only render objects on layer two:\
\
![image](https://github.com/KingToot14/radar_shader/assets/46078617/e22fa0af-cc91-4daa-83eb-41aa9d56c4b8)

There are also some additional settings I changed that give us a better result. `Disable 3D` is useful since we're only rendering a 2D scene (unless you need 3D rendering). `Transparent BG` is useful since we will be overlaying the content of Blip Viewport onto another image. Finally, `Handle Input Locally` is unchecked since this viewport doesn't need to do any input handling

Now onto the ViewportTexture. We can create one of these in a TextureRect using the dropdown menu:\
\
![image](https://github.com/KingToot14/radar_shader/assets/46078617/b4d4dda3-e64a-484d-a347-1885455c5bc5)

When the ViewportTexture is created, it will ask us for a viewport and we will select the Blip Viewport. The final thing we need to worry about is resizing the TextureRect

By default, the rect will have a minimum size bound to the viewport's size. Typically (at least for a radar/minimap) we want this rect to be smaller than the viewport size (which is actually slightly larger than the screen size in this project). To counteract this, we simply set the `Expand Mode` of the TextureRect to 'Ignore Size' instead of 'Keep Size'. If everything went correctly, you should see the blips appear on the TextureRect and they should follow any movement the entities make!

### Additional Notes
Depending on your project layout, you may need to play around with some settings to get the blips to render correctly. For me, I had to do two things:
1. I had to make the blips 2-3 times larger than I originally expected since we are scaling down the viewport render by 4 times
2. I had to do an awkward fix to get the blips to render on top of the radar base: I set the blips to be `Top Level`, and added a RemoteTransform2D to each entity and connected it to the blip so everything still moved in sync (Any suggestions for a better method would be greatly appreciated!)\
\
![image](https://github.com/KingToot14/radar_shader/assets/46078617/20195bdf-d3b2-47ef-be5f-e13a7b3e3d49)
![image](https://github.com/KingToot14/radar_shader/assets/46078617/520a2db9-d73a-4a0d-aad4-e4b77332900d)

## Credits
All the game and shader code was created by me\
Sprites and Tiles were provided for free by [Kenney](https://kenney.nl)
 - "Good guy" and "Bad guy" Sprites: [Tiny Battle](https://kenney.nl/assets/tiny-battle)
 - Rat Sprite: [Tiny Dungeon](https://kenney.nl/assets/tiny-dungeon)
 - Tilemap: [Tiny Town](https://kenney.nl/assets/tiny-town)
