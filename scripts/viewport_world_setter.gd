class_name ViewportWorldSetter
extends SubViewport

# --- Variables --- #
@export var hide_blip_from_root_viewport: bool = true

# --- Functions --- #
func _ready():
	var viewport = get_tree().root
	
	world_2d = viewport.world_2d
	if hide_blip_from_root_viewport:
		viewport.canvas_cull_mask &= 0b1111111101
