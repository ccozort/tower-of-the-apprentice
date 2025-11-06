extends CharacterBody2D

var speed = 300
var player = null
var is_moving = true

#make it visible above all other things
func _ready():
	set_as_top_level(true)

func _physics_process(delta: float) -> void:
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("player collided")
		player = body
		is_moving = false
		position = player.position
		
