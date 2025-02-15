class_name Enemy_State_Stun extends Enemy_State

@export var animation_name: String = "stun"
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0

@export_category("AI")
@export var after_stun_state: Enemy_State

var _direction: Vector2
var _animation_finished: bool = false

func init() -> void:
	enemy.enemy_damaged.connect(_on_enemy_damaged)
	pass

func enter() -> void:
	_animation_finished = false
	# _direction = enemy.DIR_4[rand]
	enemy.set_direction(_direction)
	enemy.velocity = _direction * -knockback_speed
	enemy.update_animation(animation_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	pass
	
func exit() -> void:
	pass
	
func process(_delta: float) -> Enemy_State:
	if _animation_finished == true:
		return after_stun_state
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null
	
func update(_delta: float) -> Enemy_State:
	return null
	
func physics(_delta: float) -> Enemy_State:
	return null
	
func physics_update(_delta: float) -> Enemy_State:
	return null
	
func _on_enemy_damaged() -> void:
	state_machine.change_state(self)
	
func _on_animation_finished(_a: String) -> void:
	_animation_finished = true
