class_name DraggableObject
extends Node2D

# --- Variables --- #
@export var sprite: Sprite2D

@export var normal_scale: Vector2 = Vector2(3, 3)
@export var hover_scale: Vector2 = Vector2(3.25, 3.25)

var draggable: bool = false

# --- References --- #
var parent: RandomMovement

# --- Functions --- #
func _ready():
	parent = get_parent()

func _process(_delta):
	if not draggable:
		return
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		DragAndDropManager.dragged_object = parent
		parent.stop_moving()
		parent.position = get_viewport().get_mouse_position()
	else:
		DragAndDropManager.dragged_object = null
		parent.start_moving()

func _on_mouse_entered():
	if not DragAndDropManager.is_dragging():
		draggable = true
		sprite.scale = hover_scale

func _on_mouse_exited():
	draggable = false
	sprite.scale = normal_scale
	if DragAndDropManager.dragged_object == parent:
		DragAndDropManager.dragged_object = null
