class_name FState

func _ready() -> void:
	print('state ready')

func enter() -> void:
	pass

func exit() -> void:
	pass
	
func process(_delta: float) -> void:
	pass
	
func physics_process(_delta: float) -> void:
	pass

func get_state_name() -> String:
	push_error("Method get_state_name() must be defined.")
	return ""
