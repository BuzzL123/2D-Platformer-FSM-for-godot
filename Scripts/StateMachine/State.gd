class_name State
extends Node

@onready
var coyote_timer: Timer = %CoyoteTimer
@onready
var air_jump_delay: Timer = %AirJumpDelay
@onready
var dash_delay_timer: Timer = %DashDelayTimer

@onready 
var movement_state_lable: Label = %MovementStateLable
@onready 
var attack_state_lable: Label = %AttackStateLable

@export
var animation_name: String
@export
var move_speed: float = 300

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var sprite_2d: Sprite2D
var animations: AnimationPlayer
# Hold a reference to the parent so that it can be controlled by the state
var parent: CharacterBody2D

var move_component
#var attack_component

var data_store: Dictionary

func enter() -> void:
	animations.play(animation_name)
	pass

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null

func get_movement_input() -> float:
	# Using components
	return move_component.get_movement_direction()

func get_jump() -> bool:
	return move_component.wants_jump()

func get_crouch() -> bool:
	return move_component.wants_crouch()

func get_dash() -> bool:
	return move_component.wants_dash()

func get_jab() -> bool:
	return move_component.wants_jab()
