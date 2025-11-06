class_name PlayerMovementState extends PlayerState

static var state_name = "PlayerMovementState"

const ACCELERATION: float = 20.0
const MAX_SPEED: float = 150.0

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	animated_sprite_2d.play("walk")
	
func physics_process(delta: float) -> void:
	var input: float = player.horizontal_input * ACCELERATION
	
#	detect absence of input
	if input == 0.0:
		state_machine.transition(PlayerIdleState.state_name)
	player.velocity.x += input
	player.velocity.x = clamp(player.velocity.x, -MAX_SPEED, MAX_SPEED)
