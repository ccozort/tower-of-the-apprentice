extends Node2D

var state = "no apples"
var player_in_area = false

@export var item: InvItem 
var player = null

func _ready():
	if state == "no apples":
		$growth_timer.start()		
		
func _process(delta):
	if state =="no apples":
		$AnimatedSprite2D.play("no_apples")
	elif state == "apples":
		$AnimatedSprite2D.play("apples")
		if player_in_area:
			if Input.is_action_just_pressed("pick"):
				playercollect()
				state = "no apples"
				$growth_timer.start()		
	

func _on_pickable_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print('player in area')
		player = body
		player_in_area = true
		
func _on_pickable_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = false

func _on_growth_timer_timeout() -> void:
	if state == "no apples":
		state = "apples"

func playercollect():
	player.collect(item)
	player.health -= 1
	print(player.health)
