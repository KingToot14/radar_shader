class_name Blip
extends Node2D

# --- Variables --- #
@export var angle_dependent: bool = false
@export var fade_speed: float = 1.0

@export var fading_objects: Array[ColorRect]
var fading_alpha: float = 1.0

@export var remote_transform: RemoteTransform2D

# --- Functions --- #
func _ready():
	visible = true

func _process(delta):
	if not angle_dependent:
		return
	
	set_alpha(fading_alpha - fade_speed * delta)
	
	if GlobalObjects.radar_manager and GlobalObjects.radar_manager.close_to_angle(remote_transform.global_position):
		global_position = remote_transform.global_position
		
		set_alpha(1.0)

func set_alpha(val: float):
	fading_alpha = val
	for object in fading_objects:
		object.color.a = fading_alpha

func set_angle_dependent(val: bool):
	angle_dependent = val
	
	if remote_transform:
		remote_transform.update_position = not val
	
	if not val:
		set_alpha(1.0)

func set_fade_speed(speed: float):
	fade_speed = speed
