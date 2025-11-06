class_name PlayerIdleState extends PlayerState

static var state_name = "PlayerIdleState"

const STOP_FORCE: float = 15.0

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	animated_sprite_2d.play("idle")

func physics_process(_delta: float) -> void:
	if player.horizontal_input != 0.0:
		print('attempting transition')
		state_machine.transition(PlayerMovementState.state_name)
		
	if player.velocity.x != 0.0:
		player.velocity.x = move_toward(player.velocity.x, 0, STOP_FORCE)
