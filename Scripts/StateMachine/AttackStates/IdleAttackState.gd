extends State

@export
var Jab: State
@export 
var DeadState: State

func enter() -> void:
	super()
	attack_state_lable.text = "no attack"

func process_input(event: InputEvent) -> State:
	if get_jab():
		return Jab
	return null

func process_physics(delta: float) -> State:
	if data_store["Health"] <= 0:
		if data_store.has("DeathState"):
			return DeadState
	return null
