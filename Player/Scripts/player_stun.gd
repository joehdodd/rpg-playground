class_name State_Stun extends Player_State

@export var knockback_speed: float = 25.0
@export var decelerate_speed: float = 20.0
@export var invulnerable_duration: float = 0.7

var hurt_box: HurtBox
var direction: Vector2
var next_state: Player_State = null

@onready var idle: Player_State = $"../Idle"

func init() -> void:
	player.player_damaged.connect(_player_damaged)

func enter() -> void:
	print("enter stun")
	next_state = null
	player.animation_player.animation_finished.connect(_animation_finished)
	
	direction = player.global_position.direction_to(hurt_box.global_position)
	player.velocity = direction * -knockback_speed
	
	player.set_direction()
	player.update_animation("stun")
	
	player.make_invulnerable(invulnerable_duration)
	pass
	
func exit() -> void:
	player.animation_player.animation_finished.disconnect(_animation_finished)
	pass
	
func process(_delta: float) -> Player_State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	return next_state
	
func physics(_delta: float) -> Player_State:
	return null
	
func _player_damaged(_hurt_box: HurtBox) -> void:
	hurt_box = _hurt_box
	player_state_machine.change_state(self)
	pass
	
func _animation_finished(_a: String) -> void:
	print("animation_finished_stun")
	next_state = idle
	pass
