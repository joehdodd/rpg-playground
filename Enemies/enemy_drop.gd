extends CharacterBody2D

@export var SPEED: int = 150

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var area_2d: Area2D = $Area2D

var veloc: Vector2
var spawn_pos: Vector2
var spawn_rotation: float = 0.0
var destroy_projectile = false
var _entered: bool = false

func _ready() -> void:
	area_2d.area_entered.connect(_area_entered)
	global_position = spawn_pos
	global_rotation = spawn_rotation

func _physics_process(delta):
	var direction  = global_position.direction_to(PlayerManager.player.global_position)
	if _entered: 
		var collision = move_and_collide(direction * SPEED * delta)
		if collision:
			if collision.get_collider().name == "Player":
				print("update hpasdljkdskljdskjlsd")
				PlayerManager.player.update_hp(1)
				_collision_detected()

func _area_entered() -> void:
	print("entered")
	_entered = true
	pass

func _collision_detected() -> void:
	_free_projectile()
	
func _free_projectile() -> void:
	queue_free()
