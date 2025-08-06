class_name PS3ControllerHandler


func update_input(
	input_map: Dictionary[String, float],
	event: InputEvent,
	device: int,
	dead_zone: float = 0.0) -> void:
	if event.device != device:
		return
	for action in input_map:
		if event.is_action(action):
			if event is InputEventJoypadMotion:
				var action_strength: float = abs(event.axis_value)
				if action == "left":
					input_map["left"] = 0.0
					input_map["right"] = 0.0
					if action_strength <= dead_zone:
						return
					elif event.axis_value >= 0:
						input_map["right"] = action_strength
					else:
						input_map["left"] = action_strength
				elif action == "up":
					input_map["up"] = 0.0
					input_map["down"] = 0.0
					if action_strength <= dead_zone:
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
