class_name StageMenu extends Control


@onready var track_one_button: Button = $GridContainer/TrackOneButton
@onready var track_two_button: Button = $GridContainer/TrackTwoButton
@onready var track_three_button: Button = $GridContainer/TrackThreeButton
@onready var back_button: Button = $GridContainer/BackButton
@onready var player_count_slider: Slider = $GridContainer/HSlider
@onready var player_label: Label = $GridContainer/PlayerLabel


var hover_sfx: AudioStream = preload("res://SFX/MainHoverSFX.wav")


func _ready() -> void:
	track_one_button.pressed.connect(start_stage.bind(
		{
			"camera_zoom": 0.75,
			"timer_position": Vector2.ZERO,
			"header_position": Vector2(0, -372.0),
			"track_name": "track_1"
		}
	))
	track_one_button.mouse_entered.connect(_on_enter)
	
	track_two_button.pressed.connect(start_stage.bind(
		{
			"camera_zoom": 0.6,
			"timer_position": Vector2(128, 30),
			"header_position": Vector2(0, 450.0),
			"track_name": "track_2"
		}
	))
	track_two_button.mouse_entered.connect(_on_enter)
	
	track_three_button.pressed.connect(start_stage.bind(
		{
			"camera_zoom": 0.6,
			"timer_position": Vector2(0, 465),
			"header_position": Vector2(0, -500.0),
			"track_name": "track_3"
		}
	))
	track_two_button.mouse_entered.connect(_on_enter)
	
	back_button.pressed.connect(back_to_main_menu)
	back_button.mouse_entered.connect(_on_enter)
	
	player_label.text = "Players: %d" % player_count_slider.value


func start_stage(args: Dictionary) -> void:
	args["players"] = player_count_slider.value
	SceneHelper.replace_scene(self, "res://stages/stage.tscn", args)


func back_to_main_menu() -> void:
	SceneHelper.replace_scene(self, "res://main_menu.tscn")


func _on_enter() -> void:
	AudioManager.play_audio(hover_sfx)


func _process(delta: float) -> void:
	player_label.text = "Players: %d" % player_count_slider.value
