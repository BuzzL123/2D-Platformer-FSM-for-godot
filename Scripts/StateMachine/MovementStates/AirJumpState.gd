extends AirState

@export
var JumpState: State




func enter() -> void:
	super()
	air_jump_delay.start()
	parent.velocity.y = -JumpForce
	movement_state_lable.text = "double jump"
	
func process_physics(delta: float) -> State:
	if parent.velocity.y < 0:
		return JumpState
	if parent.velocity.y > 0:
		return FallState
	return null
