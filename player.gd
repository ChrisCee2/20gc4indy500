class_name Player extends RigidBody2D


signal lapped


@onready var input_controller: InputController = $InputController
@onready var move_controller: MoveController = $MoveController


var player_keys: Dictionary = {}
var device: int = -1
var passed_finish_line: bool = true
var lap_started: bool = false
var laps_completed: int = 0
var disabled = false


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
	if not disabled:
		move_controller.update(input_controller.get_direction())


func lap() -> void:
	laps_completed += 1
	emit_signal("lapped")
