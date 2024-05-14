class_name RandomMovement
extends Node2D

# --- Constants --- #
const TOLERANCE: float = 4.0

# --- Variables --- #
var home_position: Vector2
@export var movement_range: Vector2 = Vector2(20, 20)
@export var max_velocity: float = 25
@export var acceleration: float = 10

var target_pos: Vector2 = Vector2.ZERO
var velocity: Vector2
var terminal_velocity: Vector2

var moving: bool = true

# --- Functions --- #
func _ready():
	start_moving()
	terminal_velocity = Vector2(max_velocity, max_velocity)
	find_new_target()

func _process(delta):
	if not MovementManager.movement_allowed or not moving:
		return
	
	if reached_target():
		find_new_target()
	
	velocity = clamp(velocity + position.direction_to(target_pos) * Vector2(acceleration, acceleration) * delta, -terminal_velocity, terminal_velocity)
	
	position += velocity * delta

func find_new_target() -> void:
	target_pos = home_position + Vector2(randf_range(0, movement_range.x), randf_range(0, movement_range.y)) - movement_range / 2

func reached_target() -> bool:
	return position.distance_to(target_pos) < TOLERANCE

func start_moving():
	moving = true
	home_position = position
	find_new_target()

func stop_moving():
	moving = false
