class_name Track extends Node

@export var spawn: Node2D
@export var spawn_offset: float = 64 # From top downwards


func spawn_players(players: Node) -> void:
	if players:
		var current_spawn_offset: float = spawn_offset
		for player in players.get_children():
			player.global_position = spawn.global_position + (current_spawn_offset * Vector2.DOWN)
			player.global_rotation = spawn.global_rotation
			current_spawn_offset += spawn_offset
