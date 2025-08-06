class_name InputController extends Node

@export_range(0, 1) var controller_dead_zone: float = 0.2

var retro_bit_controller_handler: RetroBitControllerHandler = RetroBitControllerHandler.new()
var ps3_controller_handler: PS3ControllerHandler = PS3ControllerHandler.new()

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
func update_input(event: InputEvent, device: int) -> void:
	if event.device != device:
		return
	ps3_controller_handler.update_input(input_map, event, device, controller_dead_zone)


# Run on unhandled_input
func update_keyboard_input(event: InputEvent, device: int, keys: Dictionary) -> void:
	if keys.size() != 0:
		if event is InputEventKey and !keys.get(event.as_text_keycode(), false):
			return
	for action in input_map:
		if event.is_action(action):
			if event.is_pressed():
				input_map[action] = 1.0
			elif event.is_released():
				input_map[action] = 0.0
			return
