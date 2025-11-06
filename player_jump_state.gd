class_name PlayerJumpState extends PlayerState

static var state_name = "PlayerJumpState"

const JUMP_FORCE: float = 350.0
const JUMP_MAX_FORCE: float = 2000.0

const ACCELERATION: float = 20.0
const MAX_SPEED: float = 150.0
const STOP_FORCE: float = 5.0

var _is_jumping: float = false

func get_state_name() -> String:
	return state_name

func enter() -> void:
	if player.is_on_floor():
		print('player on floor')
		player.velocity.y = -JUMP_FORCE
		
	_is_jumping = true
	
func exit() -> void:
	_is_jumping = false
		
func process(_delta: float) -> void:
	var anim: String

func physics_process(_delta: float) -> void:
	var input: float = player.horizontal_input * ACCELERATION
	
#	detect on ground
	if player.is_on_floor() and _is_jumping:
		if input == 0.0:
			state_machine.transition(PlayerIdleState.state_name)
		else:
			state_machine.transition(PlayerMovementState.state_name)
	
	if abs(input) < ACCELERATION * 0.2:
		player.velocity.x = move_toward(player.velocity.x, 0, STOP_FORCE)
	else:
		player.velocity.x += input
		
	player.velocity.x = clamp(player.velocity.x, -MAX_SPEED, MAX_SPEED)
