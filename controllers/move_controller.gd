class_name MoveController extends Node

@export var rigid_body: RigidBody2D
@export var speed: float = 1.0
@export var torque: float = 4.0

var speed_multiplier: float = 10000
var torque_multiplier: float = 10000

func update(direction: Vector2) -> void:
	if rigid_body == null:
		return
	var forward_direction: Vector2 = rigid_body.global_transform.y
	rigid_body.apply_central_force(forward_direction * direction.y * speed * speed_multiplier * rigid_body.mass)
	if rigid_body.linear_velocity.length() >= 200:
		# Consider scaling torque to current velocity instead of this value
		rigid_body.apply_torque(direction.x * torque * torque_multiplier * rigid_body.mass)
