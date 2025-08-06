class_name Player extends RigidBody2D

@onready var input_controller: InputController = $InputController
@onready var move_controller: MoveController = $MoveController


var device: int = -1


func set_device(device: int) -> void:
	self.device = device
	print(self)
	print(device)


func _unhandled_key_input(event: InputEvent) -> void:
	input_controller.update_keyboard_input(event, device)


func _input(event: InputEvent) -> void:
	print(device)
	input_controller.update_input(event, device)


func _physics_process(delta: float) -> void:
	move_controller.update(input_controller.get_direction())
