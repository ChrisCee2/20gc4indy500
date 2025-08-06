class_name Multiplayer extends Node2D

@onready var players: Node = $Players

var player_keys: Dictionary = {
	0: {"Up": true, "Left": true, "Down": true, "Right": true},
	1: {"W": true, "A": true, "S": true, "D": true}
}


func _ready() -> void:
	var i: int = 0
	for player in players.get_children():
		if player is Player:
			player.set_device(i)
			player.set_keys(player_keys[i])
			i += 1
