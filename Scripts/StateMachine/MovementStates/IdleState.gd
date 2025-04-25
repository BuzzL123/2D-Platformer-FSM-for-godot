extends State

@export
var FallState: State
@export
var JumpState: State
@export
var MoveState: State
@export
var CrouchState: State
@export 
var DeadState: State
func enter() -> void:
	super()
	parent.velocity.x = 0
	movement_state_lable.text = "idle"

func process_input(event: InputEvent) -> State:
	if get_jump() and parent.is_on_floor() || !coyote_timer.is_stopped():
		return JumpState
	if get_crouch():
		return CrouchState
	if get_movement_input():
		return MoveState
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return FallState
	if data_store["Health"] <= 0:
		return DeadState

	return null
