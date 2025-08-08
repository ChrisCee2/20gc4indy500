class_name FinishLine extends Area2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player.on_enter_finish_line()


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player.on_exit_finish_line()
