extends MovementState

@export 
var MoveState: State
@export
var coyote_duration := 0.25  # seconds of allowed hang time

var jumping = false

func enter() -> void:
	super()
	movement_state_lable.text = "coyote"
	jumping = false
	coyote_timer.wait_time = coyote_duration

func process_input(event: InputEvent) -> State:
	if get_jump() and (parent.is_on_floor() or coyote_timer.time_left > 0.0):
		jumping = true
		print("Jump from Coyote Time!")
		return JumpState
	return null

func process_physics(delta: float) -> State:
	print("Coyote Timer Left: ", coyote_timer.time_left)
	
	parent.velocity.y += gravity * delta
	
	var direction = get_movement_input() * move_speed
	
	if direction == 0:
		return IdleState

	sprite_2d.flip_h = direction < 0
	parent.velocity.x = direction
	parent.move_and_slide()

	if coyote_timer.is_stopped():
		return FallState
	return null
