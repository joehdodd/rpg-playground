class_name State_Roll extends Player_State

@onready var walk: Player_State = $"../Walk"
@onready var idle: Player_State = $"../Idle"
@onready var hit_box: HitBox = %HitBox

@export var move_speed: float = 100.0

var is_rolling: bool = false

func enter() -> void:
	is_rolling = true
	player.update_animation("roll")
	player.roll_animation_player.animation_finished.connect(end_attack)
	
	if is_rolling:
		hit_box.monitorable = false
	pass
	
func exit() -> void:
	is_rolling = false
	hit_box.monitorable = true
	player.roll_animation_player.animation_finished.disconnect(end_attack)
	pass
	
func process(_delta: float) -> Player_State:	
	player.velocity = player.direction * move_speed
	
	if player.set_direction():
		player.update_animation("roll")

	if is_rolling == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null
	
func physics(_delta: float) -> Player_State:
	return null
	
func handle_input(_event: InputEvent) -> Player_State:
	return null
	
func end_attack(_new_anim_name: String) -> void:
	is_rolling = false
	pass
