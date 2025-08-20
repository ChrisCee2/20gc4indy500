class_name StageMenu extends Control

@onready var stage_one_button: Button = $GridContainer/StageOneButton
@onready var back_button: Button = $GridContainer/BackButton

var select_sfx: AudioStream = preload("res://SFX/MainSelectSFX.wav")
var hover_sfx: AudioStream = preload("res://SFX/MainHoverSFX.wav")

func _ready() -> void:
	stage_one_button.pressed.connect(start_game)
	stage_one_button.mouse_entered.connect(_on_enter)
	
	back_button.pressed.connect(back_to_main_menu)
	back_button.mouse_entered.connect(_on_enter)

func start_game() -> void:
	AudioManager.play_audio(select_sfx)
	var game_scene = load("res://stages/stage_1.tscn").instantiate()
	get_tree().root.add_child(game_scene)
	get_tree().current_scene = game_scene
	queue_free()

func back_to_main_menu() -> void:
	AudioManager.play_audio(select_sfx)
	var main_menu_scene = load("res://main_menu.tscn").instantiate()
	get_tree().root.add_child(main_menu_scene)
	get_tree().current_scene = main_menu_scene
	queue_free()

func _on_enter() -> void:
	AudioManager.play_audio(hover_sfx)
