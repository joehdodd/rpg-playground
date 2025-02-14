class_name Skeleton extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSkeleton2D

func _physics_process(delta: float) -> void:
	move_and_slide()
	var animation = "idle"
		
	if velocity.x > 0:
		animation = "walk_side"
		animated_sprite.flip_h = false
	
	if velocity.y > 0:
		animation = "walk_down"
		
	if velocity.y < 0:
		animation = "walk_up"
	
	animated_sprite.play(animation)
	
	
