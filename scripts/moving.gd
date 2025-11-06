extends State
class_name PlayerMoving

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

@export var sprite : AnimatedSprite2D

@export var movespeed := int(200)

var player : CharacterBody2D

func Enter():
	#sprite.play("idle")
	player = get_tree().get_first_node_in_group("player")
	animated_sprite_2d.play("idle")

func Update(_delta:float):
	var input_dir = Input.get_vector("move_left", "move_right", "climb_up", "climb_down")
	move(input_dir)
	
func move(input_dir : Vector2):
	player.velocity = input_dir * movespeed
	player.move_and_slide()
	
	if(input_dir.length() <= 0):
		Transition("Idle")

func Transition(newstate: String):
	state_transition.emit(self, newstate)

func Exit():
	pass
