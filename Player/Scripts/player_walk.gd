class_name State_Walk extends Player_State

@export var move_speed: float = 50.0
@onready var idle: Player_State = $"../Idle"
@onready var attack: Player_State = $"../Attack"
@onready var roll: Player_State = $"../Roll"

func enter() -> void:
	player.update_animation("walk")
	pass
	
func exit() -> void:
	pass
	
func process(_delta: float) -> Player_State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	
	if player.set_direction():
		player.update_animation("walk")
	return null
	
func physics(_delta: float) -> Player_State:
	return null
	
func handle_input(_event: InputEvent) -> Player_State:
	if _event.is_action_pressed("attack"):
		return attack
	if _event.is_action_pressed("roll"):
		return roll
	else:
		return null
