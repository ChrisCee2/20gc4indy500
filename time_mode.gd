class_name TimeMode extends Node


@onready var start_timer: Timer = $Timer


@export var laps: int = 2
@export var players: Node


var start_time: int = 0
var time_to_start: float = 3


func _ready() -> void:
	start_timer.one_shot = true
	start_timer.timeout.connect(start)
	
	for object in players.get_children():
		if object is Player:
			object.disabled = true
			object.lapped.connect(check_win_condition.bind(object))


func start() -> void:
	# Set up timer ui with
	# Also hide the start timer ui
	start_time = Time.get_ticks_msec()
	for object in players.get_children():
		if object is Player:
			object.disabled = false


func init() -> void:
	start_timer.start(time_to_start)
	# Have UI connected to this timer?


func get_current_time() -> int:
	# use this for Timer ui
	return Time.get_ticks_msec() - start_time


func check_win_condition(player: Player) -> void:
	if player.laps_completed >= laps:
		var finish_time: int = get_current_time()
		# Stop timer UI and show press space bar to go back to main menu
