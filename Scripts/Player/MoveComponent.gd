extends Node

# Return the desired direction of movement for the character
# in the range [-1, 1], where positive values indicate a desire
# to move to the right and negative values to the left.
var is_input_enabled := true

func get_movement_direction() -> float:
	if is_input_enabled:
		return Input.get_axis("left", "right")
	return 0.0


# Return a boolean indicating if the character wants to jump
func wants_jump() -> bool:
	return Input.is_action_just_pressed('jump')

func wants_crouch() -> bool:
	return Input.is_action_pressed('crouch')

func wants_dash() -> bool:
	return Input.is_action_pressed("dash")
	
func wants_jab() -> bool:
	return Input.is_action_just_pressed("Jab!")
