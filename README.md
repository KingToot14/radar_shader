# Radar Shader
https://github.com/KingToot14/radar_shader/assets/46078617/341e35b7-19b1-4021-bc6f-358a2ac1f69f

A simple test project for a radar/minimap system with shaders

## Shaders
This example project incldues 3 shaders for the radar:
1. The radar scanner line ([Link](https://godotshaders.com/shader/radar-scanner))
2. The main circle in the radar "blip" ([Link](https://godotshaders.com/shader/radar-blip))
3. The expanding ring around the blips ([Link](https://godotshaders.com/shader/radar-blip-ring))

## How it Works
I think looking aroudn in the demo project will help more than anything, but I will try to explain what's going on:\

First of all, in each entity (good guys, bad guys, rat), we have a "blip" object. This object is special in that it isn't supposed to be rendered by the normal viewport, but only by a special viewport designed for the radar. To do this, we use a visibility layer (Note how only the second layer is selected)\
![image](https://github.com/KingToot14/radar_shader/assets/46078617/69f4a2e5-d94f-4bcf-9e5e-5e5c1d6c7391)\

By default, objects use the first layer. However, our blips use the second layer, which allows us to isolate them from other objects. In Godot, we can use SubViewports to create separately rendered content\
![image](https://github.com/KingToot14/radar_shader/assets/46078617/693bc7b2-fbcc-48c8-8b53-331ce8292416)\

Under normal circumstances, the SubViewport only renders its children, but we can create a workaround for this by setting the world_2d value
```gdscript
var viewport = get_tree().root
world_2d = viewport.world_2d
```

## Other Systems
Also included in this project is a simple movement script and a drag-and-drop system 

## Credits
All the game and shader code was created by me\
Sprites and Tiles were provided for free by [Kenney](https://kenney.nl)
 - "Good guy" and "Bad guy" Sprites: [Tiny Battle](https://kenney.nl/assets/tiny-battle)
 - Rat Sprite: [Tiny Dungeon](https://kenney.nl/assets/tiny-dungeon)
 - Tilemap: [Tiny Town](https://kenney.nl/assets/tiny-town)
