class_name RadarManager
extends Control

# --- Variables --- #
@export var rotation_speed: float = 2.0
@export var shader_rect: ColorRect

@export var center_point: Node2D

var radar_angle: float

# --- Constants --- #
const TOLERANCE: float = 0.05
const TWO_PI: float = 6.28318530718

# --- Functions --- #
func _ready():
	GlobalObjects.radar_manager = self

func _process(delta):
	radar_angle = fmod((radar_angle + rotation_speed * delta), TWO_PI)
	shader_rect.material.set_shader_parameter('radar_angle', radar_angle)

func close_to_angle(pos: Vector2):
	var diff = center_point.global_position - pos
	
	var angle = fmod(atan2(diff.y, diff.x) + TWO_PI, TWO_PI)
	
	return abs(radar_angle - angle) < TOLERANCE
