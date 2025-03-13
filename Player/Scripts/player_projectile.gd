class_name State_Projectile extends Player_State

const PROJECTILE_SCENE_PATH: String = "res://Player/Arrow.tscn"

@onready var projectile = preload(PROJECTILE_SCENE_PATH)
@onready var projectile_area: Marker2D = $"../../AttackBowSprites/ProjectileArea"
@onready var idle: Player_State = $"../Idle"
@onready var walk: Player_State = $"../Walk"
@onready var animation_player: AnimationPlayer = $"../../BowAnimationPlayer"
@export var vision_area: VisionArea
@export var attack_area: HurtBox
@export var after_projectile_state: Player_State

var _direction: Vector2
var _can_fire_projectile: bool = true

func enter() -> void:
	player.velocity = Vector2.ZERO
	player.update_animation("projectile")
	_fire_projectile()
	pass
	
func process(delta: float) -> Player_State:
	if _can_fire_projectile == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null

func exit() -> void:
	_can_fire_projectile = true
	pass

func _fire_projectile() -> void:
	await animation_player.animation_finished
	var instance = projectile.instantiate()
	instance.spawn_pos = projectile_area.global_position
	instance.spawn_rotation  = projectile_area.global_rotation
	get_parent().add_child.call_deferred(instance)
	_can_fire_projectile = false
	pass
	
func physics(_delta: float) -> Player_State:
	return null
	
func handle_input(_event: InputEvent) -> Player_State:
	return null
