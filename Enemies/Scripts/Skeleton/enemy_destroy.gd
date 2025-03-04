class_name EnemyStateDestroy extends EnemyState

const DROP_SCENE_PATH: String = "res://Enemies/enemy_drop.tscn"

@export var animation_name: String = "destroy"
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0

@onready var main = $"../.."
@onready var drop = preload(DROP_SCENE_PATH)

@export_category("AI")
var _damage_position: Vector2
var _direction: Vector2

func init() -> void:
	enemy.enemy_destroyed.connect(_on_enemy_destroyed)
	pass

func enter() -> void:
	enemy.invulnerable = true
	_direction = enemy.global_position.direction_to(_damage_position)
	enemy.set_direction(_direction)
	enemy.velocity = _direction * -knockback_speed
	enemy.update_animation(animation_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	pass
	
func exit() -> void:
	pass
	
func process(_delta: float) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null
	
func update(_delta: float) -> EnemyState:
	return null
	
func physics(_delta: float) -> EnemyState:
	return null
	
func physics_update(_delta: float) -> EnemyState:
	return null
	
func _on_enemy_destroyed(hurt_box: HurtBox) -> void:
	_damage_position = hurt_box.global_position
	_fire_projectile()
	state_machine.change_state(self)
	
func _fire_projectile() -> void:
	var instance = drop.instantiate()
	instance.spawn_pos = enemy.global_position
	get_tree().root.add_child.call_deferred(instance)
	pass
	
func _on_animation_finished(_a: String) -> void:
	enemy.queue_free()
