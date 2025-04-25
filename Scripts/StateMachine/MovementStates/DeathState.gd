extends State

@export var death_delay := 1.5

var timer := 0.0
var has_played_anim := false

func enter() -> void:
	super()
	timer = death_delay
	has_played_anim = false
	movement_state_lable.text = "dead"

	# Play death animation
	if animations.has_animation("death"):
		animations.play("death")
		has_played_anim = true

	# Mark as dead in shared state
	data_store["is_dead"] = true


func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	move_component.is_input_enabled = false
	
	parent.move_and_slide()

	timer -= delta
	if timer <= 0:
		# Reload the current scene after a short delay
		get_tree().reload_current_scene()  # This reloads the whole scene fresh
	return null
