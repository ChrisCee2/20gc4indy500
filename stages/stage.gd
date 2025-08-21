class_name Stage extends Node2D


@onready var camera: Camera2D = $Camera2D


@export var game_mode: TimeMode


var players: int = 1
var camera_zoom: float = 1


func _unhandled_key_input(event: InputEvent) -> void:
	if game_mode.is_finished and event.is_action("return_to_menu"):
		var main_menu_scene = load("res://main_menu.tscn").instantiate()
		get_tree().root.add_child(main_menu_scene)
		get_tree().current_scene = main_menu_scene
		queue_free()


func init() -> void:
	camera.zoom = Vector2.ONE * camera_zoom
	game_mode.init(players)
