class_name MoveController extends Node

@export var rigid_body: RigidBody2D
@export var max_acceleration: float = 1.0
@export var torque: float = 5.0
@export_range(0, 1) var acceleration_speed: float = 0.1 # How fast it accelerates, using lerp weirdly

var acceleration_multiplier: float = 10000
var torque_multiplier: float = 10000
var torque_direction: float = 1

var current_acceleration: float = 0

func update(direction: Vector2) -> void:
	if rigid_body == null:
		return
	var forward_direction: Vector2 = rigid_body.global_transform.y
	current_acceleration = lerpf(
		current_acceleration, 
		get_desired_acceleration(direction.y), 
		acceleration_speed
	)
	rigid_body.apply_central_force(
		forward_direction * current_acceleration * acceleration_multiplier * rigid_body.mass
	)
	if rigid_body.linear_velocity.length() >= 200 and direction.x != 0:
		# Consider scaling torque to current velocity instead of this value
		if direction.y != 0:
			torque_direction = direction.x if direction.y < 0 else -direction.x
		rigid_body.apply_torque(
			torque_direction * torque * torque_multiplier * rigid_body.mass
		)


func get_desired_acceleration(direction_y: float) -> float:
	if direction_y == 0:
		return 0.0
	return max_acceleration if direction_y > 0 else -max_acceleration
		
