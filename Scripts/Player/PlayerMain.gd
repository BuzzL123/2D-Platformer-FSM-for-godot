class_name Player
extends CharacterBody2D

@onready 
var sprite_2d: Sprite2D = $Sprite2D
@onready 
var animations = $AnimationPlayer
@onready 
var movement_state_machine: Node = $MovementStateMachine
@onready 
var attack_state_machine: Node = $AttackStateMachine
@onready 
var move_component: Node = $MoveComponent
#@onready 
#var attack_component: Node = $AttackComponent
func _ready() -> void:
	movement_state_machine.data_store = attack_state_machine.data_store
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	movement_state_machine.init(self, animations, sprite_2d, move_component)
	attack_state_machine.init(self, animations, sprite_2d, move_component)

func _unhandled_input(event: InputEvent) -> void:
	movement_state_machine.process_input(event)
	attack_state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	movement_state_machine.process_physics(delta)
	attack_state_machine.process_physics(delta)

func _process(delta: float) -> void:
	movement_state_machine.process_frame(delta)
	attack_state_machine.process_frame(delta)
