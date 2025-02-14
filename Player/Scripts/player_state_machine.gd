class_name PlayerStateMachine extends Node

var states: Array[PlayerState]
var prev_state: PlayerState
var current_state: PlayerState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ChangeState(current_state.Process(delta))
	pass
	
func _physics_process(delta: float) -> void:
	ChangeState(current_state.Physics(delta))
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	ChangeState(current_state.HandleInput(event))
	
func Initialize(_player: Player) -> void:
	states = []
	
	for child in get_children():
		if child is PlayerState:
				states.append(child)
	
	if states.size() > 0:
		states[0].player = _player
		ChangeState(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT
	
func ChangeState(new_state: PlayerState) -> void:
	if new_state == null || new_state == current_state:
		return
	
	if current_state:
			current_state.Exit()
			
	prev_state = current_state
	current_state = new_state
	current_state.Enter()
