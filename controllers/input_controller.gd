class_name InputController extends Node

@export_range(0, 1) var controller_deadzone: float = 0.2

var input_map: Dictionary[String, float] = {
	"up": 0.0,
	"down": 0.0,
	"left": 0.0,
	"right": 0.0
}


func get_direction() -> Vector2:
	var direction: Vector2 = Vector2(
		input_map["right"] - input_map["left"],
		input_map["down"] - input_map["up"]
	)
	var amount: float = min(direction.length(), 1.0)
	return direction.normalized() * amount


# Run on input
func update_input(event: InputEvent) -> void:
	for action in input_map:
		if event.is_action(action):
			if event is InputEventJoypadMotion:
				var action_strength: float = abs(event.axis_value)
				if action == "left":
					input_map["left"] = 0.0
					input_map["right"] = 0.0
					if action_strength <= controller_deadzone:
						return
					elif event.axis_value >= 0:
						input_map["right"] = action_strength
					else:
						input_map["left"] = action_strength
				elif action == "up":
					input_map["up"] = 0.0
					input_map["down"] = 0.0
					if action_strength <= controller_deadzone:
						return
					elif event.axis_value >= 0:
						input_map["down"] = action_strength
					else:
						input_map["up"] = action_strength
				else:
					input_map[action] = action_strength
			else:
				input_map[action] = 1.0
			return

# Run on unhandled_input
func update_keyboard_input(event: InputEvent) -> void:
	for action in input_map:
		if event.is_action(action):
			if event.is_pressed():
				input_map[action] = 1.0
			elif event.is_released():
				input_map[action] = 0.0
			return
