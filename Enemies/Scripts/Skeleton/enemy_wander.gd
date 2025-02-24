class_name EnemyStateWander extends EnemyState

@export var animation_name: String = "walk"
@export var wander_speed: float = 5.0

@export_category("AI")
@export var state_animation_duration: float = 0.5
@export var state_cycles_min: int = 1
@export var state_cycles_max: int = 3
@export var after_wander_state: EnemyState

var _timer: float = 0.0
var _direction: Vector2

func init() -> void:
	pass

func enter() -> void:
	_timer = randi_range(state_cycles_min, state_cycles_max) * state_animation_duration
	var rand = randi_range(0, 3)
	_direction = enemy.DIR_4[rand]
	enemy.velocity = _direction * wander_speed
	enemy.set_direction(_direction)
	enemy.update_animation(animation_name)
	pass
	
func exit() -> void:
	pass
	
func process(_delta: float) -> EnemyState:
	_timer -= _delta
	if _timer < 0:
		return after_wander_state
	return null
	
func update(_delta: float) -> EnemyState:
	return null
	
func physics(_delta: float) -> EnemyState:
	return null
	
func physics_update(_delta: float) -> EnemyState:
	return null
