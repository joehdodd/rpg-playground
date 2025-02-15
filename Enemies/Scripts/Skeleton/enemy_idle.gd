class_name Enemy_State_Idle extends Enemy_State

@export var animation_name: String = "idle"

@export_category("AI")
@export var state_duration_min: float = 0.5
@export var state_duration_max: float = 1
@export var after_idle_state: Enemy_State

var _timer: float = 0.0

func init() -> void:
	pass

func enter() -> void:
	enemy.velocity = Vector2.ZERO
	_timer = randf_range(state_duration_min, state_duration_max)
	enemy.update_animation(animation_name)
	pass
	
func exit() -> void:
	pass
	
func process(_delta: float) -> Enemy_State:
	_timer -= _delta
	if _timer <= 0:
		return after_idle_state
	return null
	
func update(_delta: float) -> Enemy_State:
	return null
	
func physics(_delta: float) -> Enemy_State:
	return null
	
func physics_update(_delta: float) -> Enemy_State:
	return null
