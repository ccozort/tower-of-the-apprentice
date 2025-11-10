#assets for artwork from Kenny Games URL


extends Node2D

var Bullet = preload("res://scene/projectile.tscn")

var Ball = preload("res://scene/ball.tscn")

var apple = preload("res://scene/apple_collectible.tscn")

var explosion = preload("res://scene/explode.tscn")

var apples_collected : int

@export var item: InvItem
@onready var apple_collectible: CharacterBody2D = $apple_collectible
@onready var heart_containers: HBoxContainer = $HUD/heart_containers
@onready var mana_bar: ProgressBar = $HUD/mana_bar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	drop_apple()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#heart_containers.update_partial(player.health)
	mana_bar.value = PlayerStats.remaining_mana
	if Input.is_action_just_pressed("inventory"):
		print('open inventory')

func _on_player_shoot(bullet: Variant, direction: Variant, location: Variant) -> void:
	var spawned_bullet = Bullet.instantiate()
	add_child(spawned_bullet)
	spawned_bullet.rotation = direction
	spawned_bullet.position = location
	spawned_bullet.velocity = spawned_bullet.velocity.rotated(direction)
	#
func drop_apple():
	print($Marker2D.global_position)
	for i in range(6):
		var apple_instance = apple.instantiate()
		apple_instance.global_position = $Marker2D.global_position + Vector2(randi_range(0,35),randi_range(0,35))
		add_child(apple_instance)

func _on_projectile_explode(position: Variant) -> void:
	var explode_instance = explosion.instantiate()
	explode_instance.position = position
	add_child(explode_instance)
	print(explode_instance)
	
