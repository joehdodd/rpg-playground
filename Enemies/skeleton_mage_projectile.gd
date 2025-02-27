extends CharacterBody2D

@export var SPEED: int = 100

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var dir: float
var veloc: Vector2
var spawn_pos: Vector2
var spawn_rotation: float = 0.0

func _ready() -> void:
	animation_player.play("fire")
	global_position = spawn_pos
	global_rotation = spawn_rotation
	
func _physics_process(delta):
	velocity = (veloc * SPEED).rotated(dir)
	move_and_slide()
	
	
