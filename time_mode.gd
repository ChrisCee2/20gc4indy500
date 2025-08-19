class_name TimeMode extends Node


@onready var start_timer: Timer = $Timer


@export_group("Required Nodes")
@export var players: Node
@export var start_timer_label: Label
@export var track_time_label: Label
@export_group("Settings")
@export var laps: int = 2


var start_time: int = 0
var time_to_start: float = 3
var is_started: bool = false
var is_starting: bool = false
var is_finished: bool = false
var finish_time: int = 0


func _ready() -> void:
	start_timer.one_shot = true
	start_timer.timeout.connect(start)
	
	for object in players.get_children():
		if object is Player:
			object.disabled = true
			object.lapped.connect(check_win_condition.bind(object))
	
	start_timer_label.hide()
	
	init()


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
	track_time_label.show()
	start_time = Time.get_ticks_msec()
	is_started = true
	is_finished = false
	for object in players.get_children():
		if object is Player:
			object.disabled = false


func init() -> void:
	is_starting = true
	start_timer_label.show()
	start_timer.start(time_to_start)


func get_current_time() -> int:
	return Time.get_ticks_msec() - start_time


func check_win_condition(player: Player) -> void:
	if not is_finished and player.laps_completed >= laps:
		finish_time = get_current_time()
		is_finished = true
		# Show press space bar to go back to main menu


func get_formatted_time(ms: int) -> String:
	var minutes: int = (ms / 60000)
	var seconds: int = ((ms % 60000) / 1000)
	var milliseconds: int = int(ms % 1000)

	return "%d:%02d.%03d" % [minutes, seconds, milliseconds]
