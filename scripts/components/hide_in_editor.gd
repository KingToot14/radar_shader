@tool
class_name HideInEditor
extends Node2D

# --- Variables --- #
@export var hide: bool = true

# --- Functions --- #
func _ready():
	if Engine.is_editor_hint():
		visible = not hide
	else:
		visible = true
