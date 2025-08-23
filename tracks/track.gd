class_name Track extends Node

@export var spawn: Node2D
@export var first_spawn_offset: float = 64
@export var spawn_offset: float = 64 # From top downwards
@export var spawn_angle: float = 90 # Degrees
@export var player_spawn_angle: float = -90 # Degrees


func spawn_players(players: Node) -> void:
	if players:
		var current_spawn_offset: float = 0
		var offset_direction: Vector2 = Vector2.RIGHT.rotated(deg_to_rad(spawn_angle))
		for player in players.get_children():
			player.global_position = spawn.global_position + \
			(first_spawn_offset * offset_direction) + \
			(current_spawn_offset * offset_direction)
			player.global_rotation = deg_to_rad(player_spawn_angle)
			current_spawn_offset += spawn_offset
