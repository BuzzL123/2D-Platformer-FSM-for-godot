extends Node

@export var starting_state: State

var current_state: State
var data_store := {
	"Health": 100,
	#"max_speed": 250,
	#"can_double_jump": true,
	"is_dead": false,
	"DeathState": preload("res://Scripts/StateMachine/MovementStates/DeathState.gd").new(),
}  # Shared data context

func init(parent: CharacterBody2D, animations: AnimationPlayer, sprite_2d: Sprite2D, move_component) -> void:
	for child in get_children():
		child.parent = parent
		child.animations = animations
		child.sprite_2d = sprite_2d
		child.move_component = move_component
		child.data_store = data_store
		
	# Setup death state here from your children
	if has_node("Dead"):
		data_store["death_state"] = get_node("Dead")

	if data_store["Health"] <= 0:
		return get_node("Dead")
	
	
	
	change_state(starting_state)


# Change to the new state by first calling any exit logic on the current state.
func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()
	
# Pass through functions for the Player to call,
# handling state changes as needed.
func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)


	
	
