extends CharacterBody2D
#create a signal to allow instances to be create in the game node
signal  shoot(bullet, direction, location)

const GRAVITY = 980
const SPEED = 200.0
const CLIMB_SPEED = 100.0
const JUMP_VELOCITY = -200.0

var Bullet = preload("res://scene/projectile.tscn")
var Ball = preload("res://scene/ball.tscn")
var on_ladder: bool
var climbing: bool
var hurting: bool
var health = 10
var player_direction = "none"
var player_on_floor = false
var player_crouching = false

@export var inv: Inv
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var marker_2d: Marker2D = $Marker2D
@onready var heart_containers: HBoxContainer = $"../HUD/heart_containers"
@onready var timer: Timer = $Timer


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#shoot.emit(Bullet, rotation, position)
			shoot.emit(Bullet, marker_2d.rotation, marker_2d.global_position)

func _on_climbable_body_entered(body: Node2D) -> void:
	on_ladder = true
	print("im on a ladder")
func _on_climbable_body_exited(body: Node2D) -> void:
	on_ladder = false

	
func _ready() -> void:
	print('player ready')
	timer.start()

func _physics_process(delta: float) -> void:
	#player_animation()
	marker_2d.look_at(get_global_mouse_position())
#	movement
