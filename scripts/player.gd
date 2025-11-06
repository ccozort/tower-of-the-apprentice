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
	var grounded = is_on_floor()
	
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	#print(on_ladder)
	if on_ladder:
		$AnimatedSprite2D.play('climb')
		var vertical_dir = Input.get_axis('climb_up', 'climb_down')
		if vertical_dir:
			velocity.y = vertical_dir * CLIMB_SPEED
			climbing = true
		else:
			velocity.y = move_toward(velocity.y, 0, CLIMB_SPEED)
			if grounded:
				climbing = false		
		if climbing:
			#$AnimatedSprite2D.play('climb')
			if vertical_dir:
				$AnimatedSprite2D.play('climb')
			else: 
				$AnimatedSprite2D.pause()
	elif not grounded:
		velocity.y += GRAVITY * delta
		# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and not climbing:
		velocity.y = JUMP_VELOCITY
	
	if horizontal_direction:
		velocity.x = horizontal_direction * SPEED
		if on_ladder: 
			climbing = not grounded
		else:
			climbing = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if horizontal_direction > 0:
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("walk")
	elif horizontal_direction < 0:
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("walk")
	elif horizontal_direction == 0 and not on_ladder:
		animated_sprite_2d.play("idle")
	#else:
		#player_direction = "none"
	#if Input.is_action_just_pressed("crouch") and is_on_floor():
		#print("I am crouching")
		#player_crouching = true
	#else:
		#player_crouching = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	move_and_slide()

func player_animation():
	if player_direction == "none":
		#if player_on_floor == false and not climbing:
			#animated_sprite_2d.play("jump")
		animated_sprite_2d.play("idle")
	elif player_direction == "left":
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("walk")
	elif player_direction == "right":
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("walk")
	#if player_crouching:
		#animated_sprite_2d.play("crouch")

func collect(item):
	#pass
	print("player collected item")
	inv.insert(item)


func _on_timer_timeout() -> void:
	if hurting:
		health -= 1


func _on_hurtbox_body_entered(body: Node2D) -> void:
	print("i'm being damaged")
	hurting = true


func _on_hurtbox_body_exited(body: Node2D) -> void:
	print("i'm not being damaged")
	hurting = false
