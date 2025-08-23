class_name CollisionToggler extends Area2D


@export var mask: int = 1
@export var update_z_layer: bool = false
@export var z_layer: int = 0


func _ready() -> void:
	body_entered.connect(_on_enter)


func _on_enter(body: Node2D) -> void:
	if body is Player:
		body.collision_mask = mask
		if update_z_layer:
			body.z_index = z_layer
