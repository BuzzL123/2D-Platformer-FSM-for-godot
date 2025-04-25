extends State

@export
var FallState: State
@export
var IdleState: State
@export
var JumpState: State
@export
var MoveState: State
@export
var DashState: State

func enter() -> void:
	super()
	movement_state_lable.text = "crouch"
	
func process_input(event: InputEvent) -> State:
	if get_jump() and parent.is_on_floor():
		return JumpState
	if !get_crouch():
		return MoveState
	#if get_dash() and dash_delay_timer.is_stopped():
		#return DashCrouchState
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	var direction = get_movement_input() * move_speed
	
	if direction == 0 and !get_crouch():
		return IdleState
	
	sprite_2d.flip_h = direction < 0
	parent.velocity.x = direction
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return FallState
	
	return null
