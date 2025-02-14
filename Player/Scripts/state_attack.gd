class_name State_Attack extends PlayerState

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var walk: PlayerState = $"../Walk"
@onready var idle: PlayerState = $"../Idle"
@onready var hurt_box: HurtBox = $"../../Interactions/HurtBox"

@export var attack_sound: AudioStream
@export_range(1, 20, 0.5) var decelerate_speed: float = 5.0

var is_attacking: bool = false

func Enter() -> void:
	player.UpdateAnimation("attack")
	animation_player.animation_finished.connect(EndAttack)
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(1, 1.3)
	audio.play()
	is_attacking = true
	
	await get_tree().create_timer(0.075).timeout
	hurt_box.monitoring = true
	pass
	
# What happens when the player exit this tate?
func Exit() -> void:
	animation_player.animation_finished.disconnect(EndAttack)
	is_attacking = false
	hurt_box.monitoring = false
	pass
	
func Process(_delta: float) -> PlayerState:
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if is_attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
			
	return null
	
func Physics(_delta: float) -> PlayerState:
	return null
	
func HandleInput(_event: InputEvent) -> PlayerState:
	return null
	
func EndAttack(_new_anim_name: String) -> void:
	is_attacking = false
