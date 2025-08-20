class_name StageMenu extends Control


@onready var stage_one_button: Button = $GridContainer/StageOneButton
@onready var back_button: Button = $GridContainer/BackButton


var hover_sfx: AudioStream = preload("res://SFX/MainHoverSFX.wav")


func _ready() -> void:
	stage_one_button.pressed.connect(start_game)
	stage_one_button.mouse_entered.connect(_on_enter)
	
	back_button.pressed.connect(back_to_main_menu)
	back_button.mouse_entered.connect(_on_enter)


func start_game() -> void:
	SceneHelper.replace_scene(self, "res://stages/stage_1.tscn")


func back_to_main_menu() -> void:
	SceneHelper.replace_scene(self, "res://main_menu.tscn")


func _on_enter() -> void:
	AudioManager.play_audio(hover_sfx)
