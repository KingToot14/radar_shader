class_name SettingsButton
extends Control

# --- Variables --- #
@export var radar_panel: Control
@export var minimap_panel: Control

@export_group("Angle Toggle", "angle_")
@export var angle_label: Label
@export var angle_toggle: CheckButton

# --- Functions --- #
func toggle_movement(toggled_on: bool) -> void:
	MovementManager.set_movement(not toggled_on)

func toggle_angle_dependent(toggled_on: bool) -> void:
	get_tree().call_group('blip', 'set_angle_dependent', toggled_on)

func set_fade_speed(value: float) -> void:
	get_tree().call_group('blip', 'set_fade_speed', value)

func set_minimap_mode(toggled_on: bool) -> void:
	radar_panel.visible = not toggled_on
	minimap_panel.visible = toggled_on
	
	angle_toggle.disabled = toggled_on
	if toggled_on:
		angle_toggle.set_pressed_no_signal(false)
		toggle_angle_dependent(false)
