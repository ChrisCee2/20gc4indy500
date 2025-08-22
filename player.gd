class_name Player extends RigidBody2D


signal lapped


@onready var input_controller: InputController = $InputController
@onready var move_controller: MoveController = $MoveController
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var fart_particles: CPUParticles2D = $FartParticles


var player_keys: Dictionary = {}
var device: int = -1
var passed_finish_line: bool = true
var lap_started: bool = false
var laps_completed: int = 0
var disabled = false
var max_animation_speed: float = 8.0
var animation_speed_scale: float = .01

var min_fart: int = 2
var max_fart: int = 12
var no_fart_range: float = 0.1
var max_fart_speed: float = 4.0
var min_fart_explosiveness: float = 0.5
var should_fart: bool = true


func _ready() -> void:
	animation_player.play("run")
	fart_particles.finished.connect(update_fart)


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


func get_current_speed() -> float:
	return maxf(linear_velocity.length(), angular_velocity) * animation_speed_scale


func _process(delta: float) -> void:
	var speed: float = get_current_speed()
	animation_player.speed_scale = minf(speed, max_animation_speed)
	
	if speed <= no_fart_range:
		should_fart = false
	else:
		should_fart = true
		if not fart_particles.emitting:
			fart_particles.emitting = true


func set_ignored_keys(keys: Dictionary[String, int]) -> void:
	input_controller.keys_to_ignore = keys


func update_fart() -> void:
	var fart_ratio: float = minf(get_current_speed() / max_fart_speed, 1.0)
	fart_particles.amount = maxi(ceili(fart_ratio * max_fart), min_fart)
	fart_particles.explosiveness = maxf(1 - fart_ratio, min_fart_explosiveness)
	
	fart_particles.emitting = should_fart
