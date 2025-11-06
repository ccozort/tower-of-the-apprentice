class_name PlayerController extends CharacterBody2D

var horizontal_input: float = 0.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var f_state_machine: FStateMachine = $FStateMachine

func _ready() -> void:
	var states: Array[FState] = [PlayerIdleState.new(self), PlayerMovementState.new(self)]
	f_state_machine.start_machine(states)
	
func _physics_process(delta: float) -> void:
		
	horizontal_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	move_and_slide()
