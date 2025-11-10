class_name FStateMachine extends Node

@export var is_log_enabled: bool = true

var current_state: FState
var states: Dictionary = {}

var _parent_node_name: String

func _ready() -> void:
	print('player state machine ready')
	print(states)

func start_machine(init_states: Array[FState]) -> void:
	_parent_node_name = get_parent().name
	for state in init_states:
		states[state.get_state_name()] = state
		
	current_state = init_states[0]
	#current_state = PlayerIdleState
	
	if is_log_enabled:
		print("[%s]: Entering state \"%s\"" % [_parent_node_name, current_state.get_state_name()])
	
	current_state.enter()
	
func _process(delta: float) -> void:
	current_state.process(delta)
	
func _physics_process(delta: float) -> void:
	if current_state == null:
		push_error("An attempt has been made to use a non-existent state in the physics process %s" % current_state)
	current_state.physics_process(delta)

func transition(new_state_name: String) -> void:
	var new_state: FState = states.get(new_state_name)
	var current_state_name = current_state.get_state_name()
	if new_state == null:
		push_error("An attempt has been made to transition to a non-existent state %s" % new_state_name)
	elif new_state != current_state:
		current_state.exit()
		
		if is_log_enabled:
			print("[%s]: Exiting state \"%s\"" % [_parent_node_name, current_state.get_state_name()])
			
		current_state = states[new_state.get_state_name()]
		
		if is_log_enabled:
			print("[%s]: Entering state \"%s\"" % [_parent_node_name, current_state.get_state_name()])
		
		current_state.enter()
	else:
		push_warning("An attempt to transition to the current state has been made.  Ignoring request.")
