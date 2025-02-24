class_name Player_State extends Node

static var player: Player
static var player_state_machine: Player_State_Machine

func _ready() -> void:
	pass
	
func init() -> void:
	pass

func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func process(_delta: float) -> Player_State:
	return null
	
func physics(_delta: float) -> Player_State:
	return null
	
func handle_input(_event: InputEvent) -> Player_State:
	return null
