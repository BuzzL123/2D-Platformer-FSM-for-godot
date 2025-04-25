extends Node

func wants_jab() -> bool:
	return Input.is_action_just_pressed("Jab!")
