class_name Stage extends Node2D


@onready var camera: Camera2D = $Camera2D
@onready var time_control: Control = $TimeControl
@onready var header_control: Control = $HeaderControl


@export var game_mode: TimeMode


var players: int = 1
var camera_zoom: float = 1
var timer_position: Vector2 = Vector2.ZERO
var header_position: Vector2 = Vector2.ZERO
var track_name: String = "track_1"


func _unhandled_key_input(event: InputEvent) -> void:
	if game_mode.is_finished and event.is_action("return_to_menu"):
		var main_menu_scene = load("res://main_menu.tscn").instantiate()
		get_tree().root.add_child(main_menu_scene)
		get_tree().current_scene = main_menu_scene
		queue_free()


func init() -> void:
	camera.zoom = Vector2.ONE * camera_zoom
	time_control.global_position = timer_position
	header_control.global_position = header_position
	var current_track: Track = load("res://tracks/%s.tscn" % track_name).instantiate()
	add_child(current_track)
	game_mode.track = current_track
	game_mode.init(players)
