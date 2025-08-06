class_name Multiplayer extends Node2D

@onready var players: Node = $Players


func _ready() -> void:
	var connected_controllers: Array[int] = Input.get_connected_joypads()
	print(connected_controllers)
	var i: int = 0
	if connected_controllers.size() > 0:
		for player in players.get_children():
			if player is Player:
				player.set_device(connected_controllers[i])
				i += 1
				if i >= connected_controllers.size():
					return
	else:
		for player in players.get_children():
			if player is Player:
				player.set_device(i)
				return
		
