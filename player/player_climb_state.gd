class_name PlayerClimbState extends PlayerState

static var state_name = "PlayerClimbState"

const CLIMB_SPEED = 100.0
const ACCELERATION: float = 10
const MAX_SPEED: float = 50.0
const STOP_FORCE: float = 5.0

func get_state_name() -> String:
	return state_name

func enter() -> void:
	player.is_climbing = true
	
func exit() -> void:
	player.is_climbing = false
		
func process(_delta: float) -> void:
	var anim: String
	if player.vertical_input != 0:
		anim = "climb"
		animated_sprite_2d.play(anim)
	else:
		animated_sprite_2d.pause()
	#animated_sprite_2d.play(anim)
	
	player.handle_facing()

func physics_process(_delta: float) -> void:
	if player.is_on_ladder:
		print("I'm on a ladder in ladder state")
		var vert_input = Input.get_axis('climb_up', 'climb_down')
		player.velocity.y = vert_input * CLIMB_SPEED

		var hor_input: float = player.horizontal_input * ACCELERATION
		player.velocity.x += hor_input
		player.velocity.x = clamp(player.velocity.x, -MAX_SPEED, MAX_SPEED)
		if player.velocity.x != 0.0:
			player.velocity.x = move_toward(player.velocity.x, 0, STOP_FORCE)
	
	elif player.is_on_floor():
		state_machine.transition(PlayerMovementState.state_name)
	else:
		state_machine.transition(PlayerMovementState.state_name)
