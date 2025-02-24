class_name Plant extends Node

## FIXME: Update based on updates to how hitbox works
## FIX: https://youtu.be/rA-pI06mpw4?si=TxkGqUkNzbqvrzQs
func _ready() -> void:
	$HitBox.damaged.connect(take_damage)
	pass

func _process(_delta: float) -> void:
	pass
	
func take_damage(_damage: HurtBox) -> void:
	queue_free()
