class_name Player extends RigidBody2D

@onready var input_controller: InputController = $InputController
@onready var move_controller: MoveController = $MoveController


func _unhandled_key_input(event: InputEvent) -> void:
	input_controller.update_input(event)


func _physics_process(delta: float) -> void:
	move_controller.update(input_controller.get_direction())
