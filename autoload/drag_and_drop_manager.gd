extends Node

# --- Variables --- #
var dragged_object: Node2D = null

# --- Functions --- #
func is_dragging():
	return dragged_object != null
