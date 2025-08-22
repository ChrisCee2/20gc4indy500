class_name MoveController extends Node

@export var rigid_body: RigidBody2D
@export var max_acceleration: float = 0.6
@export var torque: float = 3.0
@export_range(0, 1) var acceleration_speed: float = 0.05 # How fast it accelerates, using lerp weirdly
@export_range(0, 1) var deceleration_speed: float = 0.02

var acceleration_multiplier: float = 10000
var torque_multiplier: float = 10000
var torque_direction: float = 1

var current_acceleration: float = 0


func update(direction: Vector2) -> void:
	if rigid_body == null:
		return
		
	var forward_direction: Vector2 = rigid_body.global_transform.y
		
	# Apply facing direction force
	current_acceleration = get_current_acceleration(direction.y)
	rigid_body.apply_central_force(
		forward_direction * current_acceleration * acceleration_multiplier * rigid_body.mass
	)
	
	# Apply torque
	if rigid_body.linear_velocity.length() >= 100 and direction.x != 0:
		# Consider scaling torque to current velocity instead of this value
		torque_direction = 1 if rigid_body.linear_velocity.dot(forward_direction) < 0 else -1
		rigid_body.apply_torque(
			torque_direction * direction.x * torque * torque_multiplier * rigid_body.mass
		)


func get_current_acceleration(direction_y: float) -> float:
	if direction_y == 0:
		if current_acceleration > 0:
			return max(current_acceleration - deceleration_speed, 0.0)
		elif current_acceleration < 0:
			return min(current_acceleration + deceleration_speed, 0.0)
		return 0.0
	if direction_y > 0:
		return min(current_acceleration + acceleration_speed, max_acceleration)
	elif direction_y < 0:
		return max(current_acceleration - acceleration_speed, -max_acceleration)
	
	return 0.0
