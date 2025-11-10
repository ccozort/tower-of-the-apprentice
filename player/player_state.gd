class_name PlayerState extends FState

var player: PlayerController
var animated_sprite_2d: AnimatedSprite2D
var state_machine: FStateMachine
	

func _init(player_controller: PlayerController) -> void:
	print('player state init from PlayerState')
	player = player_controller
	animated_sprite_2d = player.animated_sprite_2d
	state_machine = player.f_state_machine
