class_name TimeMode extends Node


@onready var start_timer: Timer = $Timer


@export_group("Required Nodes")
@export var players: Node
@export var track: Track
@export var start_timer_label: Label
@export var track_time_label: Label
@export var end_text_label: Label
@export var lap_label: Label
@export_group("Settings")
@export var laps: int = 2


var start_time: int = 0
var time_to_start: float = 3
var is_started: bool = false
var is_starting: bool = false
var is_finished: bool = false
var finish_time: int = 0
var lap_text: String = "Lap: %d/%d"
var end_text: String = "Press space to leave"
var player = preload("res://player.tscn")


func init_players() -> void:
	for object in players.get_children():
		if object is Player:
			object.disabled = true
			object.lapped.connect(on_lap.bind(object))


func _ready() -> void:
	start_timer.one_shot = true
	start_timer.timeout.connect(start)
	
	init_players()
	
	start_timer_label.hide()
	end_text_label.hide()


func _process(delta: float) -> void:
	if is_starting:
		start_timer_label.text = str(ceili(start_timer.time_left))
	if is_started:
		if is_finished:
			track_time_label.text = get_formatted_time(finish_time)
		else:
			track_time_label.text = get_formatted_time(get_current_time())


func start() -> void:
	is_starting = false
	start_timer_label.hide()
	end_text_label.hide()
	track_time_label.show()
	start_time = Time.get_ticks_msec()
	is_started = true
	is_finished = false
	for object in players.get_children():
		if object is Player:
			object.disabled = false
	
	lap_label.show()
	lap_label.text = lap_text % [1, laps]


func init(player_count: int) -> void:
	for i in range(player_count):
		print(i)
		print(player_count)
		var new_player: Player = player.instantiate()
		players.add_child(new_player)
	
	init_players()
	track.spawn_players(players)
	is_starting = true
	start_timer_label.show()
	start_timer.start(time_to_start)


func get_current_time() -> int:
	return Time.get_ticks_msec() - start_time


func finish() -> void:
	end_text_label.text = end_text
	end_text_label.show()
	finish_time = get_current_time()
	is_finished = true


func on_lap(player: Player) -> void:
	if is_finished:
		return
	
	if player.laps_completed >= laps:
		finish()
	else:
		lap_label.text = lap_text % [player.laps_completed + 1, laps]


func get_formatted_time(ms: int) -> String:
	var minutes: int = (ms / 60000)
	var seconds: int = ((ms % 60000) / 1000)
	var milliseconds: int = int(ms % 1000)

	return "%d:%02d.%03d" % [minutes, seconds, milliseconds]
