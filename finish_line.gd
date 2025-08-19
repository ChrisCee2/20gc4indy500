class_name FinishLine extends Area2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.passed_finish_line = false
		if body.lap_started:
			body.laps_completed += 1
			body.lap_started = false
			print("LAPPED")


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.passed_finish_line = true
