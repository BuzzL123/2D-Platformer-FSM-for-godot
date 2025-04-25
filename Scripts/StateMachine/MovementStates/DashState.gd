# You could also declare a class_name for the move state
# so you don't have to reference the script directly
extends MovementState

@export
var MoveState: State

@export
var time_to_dash := 0.25
var dash_time := 0.0
var direction := 0.02

func enter() -> void:
	super()
	
	dash_time = time_to_dash

	# Simple check for which direction to dash towards
	if sprite_2d.flip_h:
		direction = -1
	else:
		direction = 1

	movement_state_lable.text = "dash"	

# Just to be safe, disable any other inputs
func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State: 
	dash_time -= delta
	if dash_time <= 0.0:
		dash_delay_timer.start()
		# Fall back on the default input implementation to
		# determine where to go next
		if super.get_movement_input() != 0.0:
			return MoveState
		return IdleState

	# At this point, run 'process_physics' in the move script as written
	return super(delta)

# Override movement inputs
func get_movement_input() -> float:
	return direction

func get_jump() -> bool:
	return false
