extends CharacterBody2D

@export var SPEED: int = 100

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var veloc: Vector2
var spawn_pos: Vector2
var spawn_rotation: float = 0.0

func _ready() -> void:
	animation_player.play("fire")
	global_position = spawn_pos
	global_rotation = spawn_rotation
	
func _physics_process(delta):
	var direction  = global_position.direction_to(PlayerManager.player.global_position)
	global_rotation = global_position.angle_to_point(PlayerManager.player.global_position)
	move_and_collide(direction * SPEED * delta)
	#if coll_info and coll_info.get_collider():
		#_collision_detected()
	
func _collision_detected() -> void:
	free_projectile()
	
func free_projectile() -> void:
	queue_free()
