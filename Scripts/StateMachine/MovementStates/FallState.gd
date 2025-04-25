extends State

@export
var IdleState: State
@export
var MoveState: State
@export
var AirJumpState: State
@export
var CrouchState: State
#@export
#var DashState: State
var coyote_frames = 6  # How many in-air frames to allow jumping
var coyote = false  # Track whether we're in coyote time or not
var last_floor = false  # Last frame's on-floor state
func enter() -> void:
	super()
	movement_state_lable.text = "fall"
	
	coyote_timer.wait_time = coyote_frames / 60.0

func process_input(event: InputEvent) -> State:
	
	if get_jump() and !parent.is_on_floor() and air_jump_delay.is_stopped():
		return AirJumpState
	#if get_dash() and dash_delay_timer.is_stopped():
		#return DashState
	
	return null
func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta

	var direction = get_movement_input() * move_speed

	sprite_2d.flip_h = direction < 0
	parent.velocity.x = direction
	parent.move_and_slide()

	if parent.is_on_floor():
		air_jump_delay.stop()
		if get_crouch() and !parent.is_on_floor():
			return CrouchState
		if direction != 0:
			return MoveState
		return IdleState
	
	return null
