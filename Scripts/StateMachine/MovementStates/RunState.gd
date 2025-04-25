class_name MovementState
extends State

@export 
var FallState: State
@export 
var IdleState: State
@export 
var JumpState: State
@export 
var CrouchState: State
@export 
var DashState: State
@export 
var CoyoteState: State
@export 
var DeadState: State

var last_floor = false

func enter() -> void:
	super()
	movement_state_lable.text = "run"

func process_input(event: InputEvent) -> State:
	if get_jump() and (parent.is_on_floor() or coyote_timer.time_left > 0.0):
		return JumpState
	if get_crouch():
		return CrouchState
	if get_dash() and dash_delay_timer.is_stopped():
		return DashState
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	var direction = get_movement_input() * move_speed
	
	if direction == 0:
		last_floor = parent.is_on_floor()
		return IdleState

	sprite_2d.flip_h = direction < 0
	parent.velocity.x = direction
	parent.move_and_slide()

	# Coyote logic here
	if !parent.is_on_floor() and last_floor and coyote_timer.is_stopped():
		print("Coyote STARTED from Movement")
		coyote_timer.start()
		last_floor = parent.is_on_floor()
		return CoyoteState

	last_floor = parent.is_on_floor()
	
	return null
