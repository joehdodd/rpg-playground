class_name State_Stun extends Player_State

@export var knockback_speed: float = 50.0
@export var decelerate_speed: float = 10.0
@export var invulnerable_duration: float = 1.0

var hurt_box: HurtBox
var direction: Vector2
var next_state: Player_State = null

@onready var idle: Player_State = $"../Idle"
@onready var walk: Player_State = $"../Walk"
@onready var attack: Player_State = $"../Attack"

func init() -> void:
	player.player_damaged.connect(_player_damaged)

func enter() -> void:
	player.animation_player.animation_finished.connect(_animation_finished)
	
	direction = player.global_position.direction_to(hurt_box.global_position)
	player.velocity = direction * -knockback_speed
	player.set_direction()
	player.update_animation("stun")
	
	player.make_invulnerable(invulnerable_duration)
	pass
	
func exit() -> void:
	next_state = null
	player.animation_player.animation_finished.disconnect(_animation_finished)
	pass
	
func process(_delta: float) -> Player_State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	return next_state
	
func physics(_delta: float) -> Player_State:
	return null
	
func _player_damaged(_hurt_box) -> void:
	hurt_box = _hurt_box
	player_state_machine.change_state(self)
	
func _animation_finished(_a: String) -> void:
	next_state = idle
