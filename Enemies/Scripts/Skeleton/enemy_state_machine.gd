class_name Enemy_State_Machine extends Node

var states: Array[Enemy_State]
var prev_state: Enemy_State
var current_state: Enemy_State

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	pass

func _process(delta: float) -> void:
	change_state(current_state.process(delta))
	pass
	
func _physics_process(delta: float) -> void:
	change_state(current_state.physics(delta))
	pass

func init(_enemy: Enemy) -> void:
	states = []
	
	for child in get_children():
		if child is Enemy_State:
				states.append(child)
	
	for state in states:
		state.enemy = _enemy
		state.state_machine = self
		state.init()
	
	if states.size() > 0:
		states[0].enemy = _enemy
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT
	
func change_state(new_state: Enemy_State) -> void:
	if new_state == null || new_state == current_state:
		return
	
	if current_state:
			current_state.exit()
			
	prev_state = current_state
	current_state = new_state
	current_state.enter()
