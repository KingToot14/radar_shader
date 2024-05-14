class_name PauseToggler
extends Node

# --- Functions --- #
func _on_toggled(toggled_on):
	MovementManager.set_movement(not toggled_on)
