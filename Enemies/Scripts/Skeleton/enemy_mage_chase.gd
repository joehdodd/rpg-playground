class_name EnemyMageStateChase extends EnemyStateChase

@onready var main = $"../.."
@onready var projectile = preload("res://Enemies/skeleton_mage_projectile.tscn")

var _can_fire_projectile = true

func init() -> void:
	if vision_area:
		vision_area.player_entered.connect(_on_player_enter)
		vision_area.player_exited.connect(_on_player_exit)
	pass

func enter() -> void:
	_timer = state_aggro_duration
	var rand = randi_range(0, 3)
	_direction = enemy.DIR_4[rand]
	enemy.update_animation(animation_name)
	
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
		return after_chase_state

	var _new_direction: Vector2 = enemy.global_position.direction_to(PlayerManager.player.global_position)
	_direction = lerp(_direction, _new_direction, turn_rate)
	
	if !_can_fire_projectile:
		enemy.velocity = _direction * chase_speed

	if enemy.set_direction(_direction):
		enemy.update_animation(animation_name)
		
	if !_can_see_player:
		_timer -= _delta
		if _timer < 0:
			return after_chase_state
	else:
		_fire_projectile()
		_timer = state_aggro_duration
	return null
	
func update(_delta: float) -> EnemyState:
	return null
	
func physics(_delta: float) -> EnemyState:
	return null
	
func physics_update(_delta: float) -> EnemyState:
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
	if _can_fire_projectile:
		var instance = projectile.instantiate()
		var angle_to_player = enemy.global_position.angle_to_point(PlayerManager.player.global_position)
		instance.spawn_pos = enemy.global_position
		instance.spawn_rotation = angle_to_player
		main.add_child.call_deferred(instance)
		_can_fire_projectile = false

func _on_timer_timeout() -> void:
	_can_fire_projectile = true
	pass
