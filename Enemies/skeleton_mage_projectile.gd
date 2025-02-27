extends CharacterBody2D

@export var SPEED: int = 25

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var veloc: Vector2
var spawn_pos: Vector2
var spawn_rotation: float = 0.0
var destroy_projectile = false

func _ready() -> void:
	animation_player.play("fire")
	global_position = spawn_pos
	global_rotation = spawn_rotation
	
func _physics_process(delta):
	if destroy_projectile:
		_free_projectile()
	var direction  = global_position.direction_to(PlayerManager.player.global_position)
	global_rotation = global_position.angle_to_point(PlayerManager.player.global_position)
	var collision = move_and_collide(direction * SPEED * delta)
	if collision:
		if collision.get_collider().name == "Player":
			_collision_detected()

func _collision_detected() -> void:
	_free_projectile()
	
func _free_projectile() -> void:
	queue_free()

func _on_timer_timeout() -> void:
	destroy_projectile = true
	pass
