class_name PlayerController extends CharacterBody2D

enum Facing {
	LEFT,
	RIGHT
}

var _facing: Facing = Facing.RIGHT

var horizontal_input: float = 0.0

var _gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var f_state_machine: FStateMachine = $FStateMachine

func _ready() -> void:
	var states: Array[FState] = [PlayerIdleState.new(self), PlayerMovementState.new(self), PlayerJumpState.new(self)]
	f_state_machine.start_machine(states)
	
func _physics_process(delta: float) -> void:
		
	horizontal_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if not is_on_floor():
		velocity.y += _gravity * delta
		f_state_machine.transition(PlayerJumpState.state_name)
		
	
	move_and_slide()

func handle_facing() -> void:
	var flip: int = 0
	
	if horizontal_input < 0.0:
		flip = 1
	elif horizontal_input > 0.0:
		flip = -1
	
	if flip == -1:
		animated_sprite_2d.flip_h = false
		_facing = Facing.RIGHT
	elif flip == 1:
		animated_sprite_2d.flip_h = true
		_facing = Facing.LEFT
