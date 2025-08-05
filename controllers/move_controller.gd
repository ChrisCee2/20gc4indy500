class_name MoveController extends Node

@export var character_body_2d: CharacterBody2D
@export var speed: float = 2

func update(direction: Vector2) -> void:
	if character_body_2d == null:
		return
	character_body_2d.move_and_collide(direction.normalized() * speed)
