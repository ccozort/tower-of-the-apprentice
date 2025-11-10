class_name PlayerMovementState extends PlayerState

static var state_name = "PlayerMovementState"

const ACCELERATION: float = 20.0
const MAX_SPEED: float = 150.0

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		print('trying to jump')
		state_machine.transition(PlayerJumpState.state_name)
		pass
	animated_sprite_2d.play("walk")
	player.handle_facing()
	
func physics_process(delta: float) -> void:
	var hor_input: float = player.horizontal_input * ACCELERATION
	var vert_input: float = player.vertical_input * ACCELERATION
#	detect absence of input
	if hor_input == 0.0:
		state_machine.transition(PlayerIdleState.state_name)
	if vert_input != 0.0 and player.is_on_ladder:
		state_machine.transition(PlayerClimbState.state_name)
	player.velocity.x += hor_input
	player.velocity.x = clamp(player.velocity.x, -MAX_SPEED, MAX_SPEED)
