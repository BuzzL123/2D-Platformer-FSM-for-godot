class_name AirState
extends State


@export
var FallState: State
@export
var IdleState: State
@export
var MoveState: State
@export
var AirJumpState: State
#@export
#var DashState: State

@export
var JumpForce: float = 600.0


func enter() -> void:
	super()
	parent.velocity.y = -JumpForce
	movement_state_lable.text = "jump"
	
func process_input(event: InputEvent) -> State:
	if get_jump() and !parent.is_on_floor() and air_jump_delay.is_stopped():
		return AirJumpState
	#if get_dash() and dash_delay_timer.is_stopped():
		#return DashState
	return null
func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	if parent.velocity.y > 0:
		return FallState
	
	var direction = get_movement_input() * move_speed

	sprite_2d.flip_h = direction < 0
	parent.velocity.x = direction
	
	parent.move_and_slide()
	
	
	if parent.is_on_floor():
		if direction != 0:
			return MoveState
		return IdleState
	
	return null
