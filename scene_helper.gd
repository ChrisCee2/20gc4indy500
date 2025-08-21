extends Node


var select_sfx: AudioStream = preload("res://SFX/MainSelectSFX.wav")


func load_scene(scene_name: String, root: Window, current_scene: Node, args: Dictionary) -> bool:
	AudioManager.play_audio(select_sfx)
	var scene = load(scene_name).instantiate()
	for key in args:
		scene.set(key, args[key])
	if scene_name == null:
		return false
	
	root.add_child(scene)
	current_scene = scene
	if scene.has_method("init"):
		scene.init()
	
	return true

func replace_scene(scene_to_replace: Node, new_scene_name: String, args: Dictionary = {}) -> bool:
	var root: Window = scene_to_replace.get_tree().root
	var current_scene: Node = scene_to_replace.get_tree().current_scene
	var loaded: bool = load_scene(new_scene_name, root, current_scene, args)
	if loaded:
		scene_to_replace.queue_free()
		return true
	return false
