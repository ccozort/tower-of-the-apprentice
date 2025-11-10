class_name PlayerController extends CharacterBody2D

@onready var grid_container: GridContainer = $"../HUD/inventory_ui_control/MarginContainer/GridContainer"


enum Facing {
	LEFT,
	RIGHT
}

signal  shoot(bullet, direction, location)

var Bullet = preload("res://scene/projectile.tscn")

var is_on_ladder: bool = false
var is_climbing: bool = false

var _facing: Facing = Facing.RIGHT

var horizontal_input: float = 0.0
var vertical_input: float = 0.0

var _gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var marker_2d: Marker2D = $Marker2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var f_state_machine: FStateMachine = $FStateMachine

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#shoot.emit(Bullet, rotation, position)
			print('shooooot')
			shoot.emit(Bullet, marker_2d.rotation, marker_2d.global_position)

func _ready() -> void:
	print(PlayerStats.remaining_mana)
	
	var states: Array[FState] = [PlayerIdleState.new(self), PlayerMovementState.new(self), PlayerJumpState.new(self), PlayerClimbState.new(self)]
	f_state_machine.start_machine(states)
	
func _physics_process(delta: float) -> void:
	marker_2d.look_at(get_global_mouse_position())
	horizontal_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	vertical_input = Input.get_action_strength("climb_up") - Input.get_action_strength("climb_down")
	
	if not is_on_floor() and not is_climbing:
		velocity.y += _gravity * delta
		f_state_machine.transition(PlayerJumpState.state_name)
	move_and_slide()

func handle_facing() -> void:
	var flip: int = 0
	
	if horizontal_input < 0.0:
		flip = 1
	elif horizontal_input > 0.0:
		flip = -1
	if flip == -1:
		animated_sprite_2d.flip_h = false
		_facing = Facing.RIGHT
	elif flip == 1:
		animated_sprite_2d.flip_h = true
		_facing = Facing.LEFT

func _on_climbable_body_entered(body: Node2D) -> void:
	print('ladder entered')
	is_on_ladder = true

func _on_climbable_body_exited(body: Node2D) -> void:
	print('ladder exited')
	is_on_ladder = false

#func collect_item(item):
	#for slot in grid_container.get_children():
		#if slot.item: continue
		#slot.item = item.get_meta("item_data")
		#slot.update_ui()
		#item.queue_free()
		#break
