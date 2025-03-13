extends CharacterBody2D

@export var SPEED: int = 200

var spawn_pos: Vector2
var spawn_rotation: float = 0.0
var destroy_projectile = false
var direction: Vector2

func _ready() -> void:
	global_position = spawn_pos
	global_rotation = spawn_rotation
	direction = PlayerManager.player.cardinal_direction

func _physics_process(delta):
	direction.y += 0.05 * delta
	rotation += 0.05 * delta
	var collision = move_and_collide(direction * SPEED * delta)
	#if collision:
		#_free_projectile()
	pass

func _collision_detected() -> void:
	_free_projectile()
	
func _free_projectile() -> void:
	queue_free()

func _on_timer_timeout() -> void:
	destroy_projectile = true
	pass
