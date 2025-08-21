class_name Player extends RigidBody2D


signal lapped


@onready var input_controller: InputController = $InputController
@onready var move_controller: MoveController = $MoveController
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var player_keys: Dictionary = {}
var device: int = -1
var passed_finish_line: bool = true
var lap_started: bool = false
var laps_completed: int = 0
var disabled = false
var max_animation_speed: float = 8.0
var animation_speed_scale: float = .01


func _ready() -> void:
	animation_player.play("run")


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
	lap_started = false
	laps_completed += 1
	emit_signal("lapped")


func _process(delta: float) -> void:
	var speed: float = maxf(linear_velocity.length(), angular_velocity) * animation_speed_scale
	animation_player.speed_scale = minf(speed, max_animation_speed)


func set_ignored_keys(keys: Dictionary[String, int]) -> void:
	input_controller.keys_to_ignore = keys
