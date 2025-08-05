class_name InputController extends Node

var input_map: Dictionary[String, bool] = {
	"up": false,
	"down": false,
	"left": false,
	"right": false
}


func get_direction() -> Vector2:
	var direction: Vector2 = Vector2.ZERO
	if input_map["up"]:
		direction += Vector2.UP
	if input_map["down"]:
		direction += Vector2.DOWN
	if input_map["left"]:
		direction += Vector2.LEFT
	if input_map["right"]:
		direction += Vector2.RIGHT
	return direction


# Run on unhandled_input
func update_input(event: InputEvent) -> void:
	for action in input_map:
		if event.is_action(action):
			if event.is_pressed():
				input_map[action] = true
			elif event.is_released():
				input_map[action] = false
			return
