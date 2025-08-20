class_name MainMenu extends Control

@onready var time_mode_button: Button = $GridContainer/TimeModeButton
@onready var exit_button: Button = $GridContainer/ExitButton

var select_sfx: AudioStream = preload("res://SFX/MainSelectSFX.wav")
var hover_sfx: AudioStream = preload("res://SFX/MainHoverSFX.wav")

func _ready() -> void:
	time_mode_button.pressed.connect(go_to_stage_select)
	time_mode_button.mouse_entered.connect(_on_enter)
	
	exit_button.pressed.connect(exit_game)
	exit_button.mouse_entered.connect(_on_enter)

func go_to_stage_select() -> void:
	AudioManager.play_audio(select_sfx)
	var game_scene = load("res://stage_menu.tscn").instantiate()
	get_tree().root.add_child(game_scene)
	get_tree().current_scene = game_scene
	queue_free()

func exit_game() -> void:
	AudioManager.play_audio(select_sfx)
	# Some hardcoded delay so the audio finished playing
	await get_tree().create_timer(select_sfx.get_length() + 0.1).timeout
	get_tree().quit()

func _on_enter() -> void:
	AudioManager.play_audio(hover_sfx)
