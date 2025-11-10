extends CharacterBody2D

var GRAVITY = 400

@export var item: InvItem 
var player = null

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		#player.collect_item(self)

	
