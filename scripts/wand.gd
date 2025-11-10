extends CharacterBody2D
@onready var grid_container: GridContainer = $"../HUD/inventory_ui_control/MarginContainer/GridContainer"

var SPEED = 1
var pickedup = false
var can_pickup = false
var on_floor = false
var collected = false
const GRAVITY = 400
var player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("wand in the world")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		print(can_pickup)
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed and can_pickup:
			
			if pickedup == false:
				pickedup = true
			else:
				pickedup = false
				
func _process(delta: float) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if pickedup:
		position = get_global_mouse_position()
	if not is_on_floor() and not pickedup:
		velocity.y += GRAVITY * delta
	move_and_slide()



func _on_mouse_collider_mouse_entered() -> void:
	can_pickup = true

func _on_mouse_collider_mouse_exited() -> void:
	can_pickup = false


func _on_player_collide_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		#print('player colliding with world object')
		#for slot in grid_container.get_children():
			#if slot.item: continue
			#slot.item = self.get_meta("item_data")
			#slot.update_ui()
			#break
		#queue_free()
