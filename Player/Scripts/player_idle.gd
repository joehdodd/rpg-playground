class_name State_Idle extends Player_State

@onready var walk: Player_State = $"../Walk"
@onready var attack: Player_State = $"../Attack"

func enter() -> void:
	player.update_animation("idle")
	pass
	
func exit() -> void:
	pass
	
func process(_delta: float) -> Player_State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null
	
func physics(_delta: float) -> Player_State:
	return null
	
func handle_input(_event: InputEvent) -> Player_State:
	if _event.is_action_pressed("attack"):
		return attack
	else: 
		return null
