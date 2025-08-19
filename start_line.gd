class_name StartLine extends Area2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.lap_started = false


func _on_body_exited(body: Node2D) -> void:
	if body is Player and body.passed_finish_line:
		body.lap_started = true
