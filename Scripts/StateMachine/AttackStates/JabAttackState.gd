extends State

@export
var IdleAttackState: State
@export 
var DeadState: State

func enter() -> void:
	super()
	attack_state_lable.text = "jab"
	
	# === Damage Logic Here ===
	if data_store.has("Health"):
		data_store["Health"] -= 25  # or whatever damage
		print("Health: ", data_store["Health"])
		
func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	if data_store["Health"] <= 0:
		return DeadState
	return IdleAttackState
