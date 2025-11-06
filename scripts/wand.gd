extends CharacterBody2D

var SPEED = 1
var pickedup = false
var can_pickup = false
var on_floor = false

const GRAVITY = 400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		print(can_pickup)
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed and can_pickup:
			
			if pickedup == false:
				pickedup = true
			else:
				pickedup = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if pickedup:
		position = get_global_mouse_position()
	if not is_on_floor() and not pickedup:
		velocity.y += GRAVITY * delta
	move_and_slide()



func _on_mouse_entered() -> void:
	print('entered')
	can_pickup = true
