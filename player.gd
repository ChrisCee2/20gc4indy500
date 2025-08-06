class_name Player extends RigidBody2D

@onready var input_controller: InputController = $InputController
@onready var move_controller: MoveController = $MoveController


var player_keys: Dictionary = {}
var device: int = -1


func set_keys(keys: Dictionary) -> void:
	player_keys = keys


func set_device(device: int) -> void:
	self.device = device


func _unhandled_key_input(event: InputEvent) -> void:
	input_controller.update_keyboard_input(event, device, player_keys)


func _input(event: InputEvent) -> void:
	return
	# input_controller.update_input(event, device)


func _physics_process(delta: float) -> void:
	move_controller.update(input_controller.get_direction())
