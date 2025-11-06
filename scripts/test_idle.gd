extends State
class_name PlayerIdle

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

@export var sprite : AnimatedSprite2D

func Enter():
	#sprite.play("idle")
	animated_sprite_2d.play("idle")
	print("player is idle")

func Update(_delta:float):
	if (Input.get_vector("move_left", "move_right", "climb_up", "climb_down")):
#		go to move state
		state_transition.emit(self, "Moving")
		print('state machine is moving...')
	if Input.is_action_just_pressed("jump"):
#		transition to jump
		state_transition.emit(self, "Jumping")
	
func Exit():
	pass
	
