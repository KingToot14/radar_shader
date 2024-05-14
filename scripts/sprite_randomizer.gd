class_name SpriteRandomizer
extends Sprite2D

# --- Variables --- #
@export var textures: Array[Texture2D]
@export var randomize_h: bool = false

# --- Functions --- #
func _ready():
	texture = textures.pick_random()
	if randomize_h:
		flip_h = randi_range(0, 1) == 1
