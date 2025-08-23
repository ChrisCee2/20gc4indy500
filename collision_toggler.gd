class_name CollisionToggler extends Area2D


@export var mask: int = 1


func _ready() -> void:
	body_entered.connect(_on_enter)


func _on_enter(body: Node2D) -> void:
	if body is Player:
		body.collision_mask = mask
