class_name EnemyStateProjectile extends EnemyState

const PROJECTILE_SCENE_PATH: String = "res://Enemies/skeleton_mage_projectile.tscn"

@onready var main = $"../.."
@onready var projectile = preload(PROJECTILE_SCENE_PATH)
@onready var projectile_area: Marker2D = $"../../ProjectileArea"

@export var animation_name: String = "fire"
@export var turn_rate: float = 0.15
@export var vision_area: VisionArea
@export var attack_area: HurtBox
@export var after_projectile_state: EnemyState
@export var after_player_dead_state: EnemyState

var _can_fire_projectile = true
var _direction: Vector2
var _can_see_player: bool = false

func init() -> void:
	if vision_area:
		vision_area.player_entered.connect(_on_player_enter)
		vision_area.player_exited.connect(_on_player_exit)
	pass

func enter() -> void:
	enemy.velocity = Vector2.ZERO
	if _can_fire_projectile:
		_fire_projectile()
	if attack_area:
		attack_area.monitoring = true
	pass

func exit() -> void:
	if attack_area:
		attack_area.monitoring = false
	_can_see_player = false
	pass

func process(_delta: float) -> EnemyState:
	if PlayerManager.player.hit_points <= 0:
		return after_player_dead_state

	var _new_direction: Vector2 = enemy.global_position.direction_to(PlayerManager.player.global_position)
	_direction = lerp(_direction, _new_direction, turn_rate)
	
	if enemy.set_direction(_direction):
		_fire_projectile()
	
	if !_can_see_player:
		return after_projectile_state
	else:
		if _can_fire_projectile:
			_fire_projectile()
	return null
	
func _on_player_enter() -> void:
	_can_see_player = true
	if state_machine.current_state is EnemyStateStun:
		return
	state_machine.change_state(self)
	pass

func _on_player_exit() -> void:
	_can_see_player = false
	pass

func _fire_projectile() -> void:
	enemy.update_animation("fire")
	await enemy.animation_player.animation_finished
	var instance = projectile.instantiate()
	var angle_to_player = enemy.global_position.angle_to_point(PlayerManager.player.global_position)
	instance.spawn_pos = projectile_area.global_position
	instance.spawn_rotation = angle_to_player
	main.add_child.call_deferred(instance)
	_can_fire_projectile = false
	pass

func _on_timer_timeout() -> void:
	_can_fire_projectile = true
	pass

func update(_delta: float) -> EnemyState:
	return null
	
func physics(_delta: float) -> EnemyState:
	return null
	
func physics_update(_delta: float) -> EnemyState:
	return null
