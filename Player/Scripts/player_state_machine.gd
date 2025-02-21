class_name Player_State_Machine extends Node

var states: Array[Player_State]
var prev_state: Player_State
var current_state: Player_State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_state(current_state.process(delta))
	pass
	
func _physics_process(delta: float) -> void:
	change_state(current_state.physics(delta))
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input(event))
	
func initialize_player_state_machine(_player: Player) -> void:
	states = []
	
	for child in get_children():
		if child is Player_State:
				states.append(child)
				
	if states.size() == 0:
		return
	
	states[0].player = _player
	states[0].player_state_machine = self
	
	for state in states:
		state.init()
	
	change_state(states[0])
	process_mode = Node.PROCESS_MODE_INHERIT
	
func change_state(new_state: Player_State) -> void:
	if new_state == null || new_state == current_state:
		return

	if current_state:
			current_state.exit()
			
	prev_state = current_state
	current_state = new_state
	current_state.enter()
