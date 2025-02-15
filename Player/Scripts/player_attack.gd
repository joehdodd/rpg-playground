class_name State_Attack extends Player_State

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var walk: Player_State = $"../Walk"
@onready var idle: Player_State = $"../Idle"
@onready var hurt_box: HurtBox = %AttackHurtBox

@export var attack_sound: AudioStream
@export_range(1, 20, 0.5) var decelerate_speed: float = 5.0

var is_attacking: bool = false

func enter() -> void:
	player.update_animation("attack")
	animation_player.animation_finished.connect(end_attack)
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(1, 1.3)
	audio.play()
	is_attacking = true
	
	await get_tree().create_timer(0.075).timeout
	hurt_box.monitoring = true
	pass
	
func exit() -> void:
	animation_player.animation_finished.disconnect(end_attack)
	is_attacking = false
	hurt_box.monitoring = false
	pass
	
func process(_delta: float) -> Player_State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if is_attacking == false:
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
	is_attacking = false
