class_name Plant extends Node

func _ready() -> void:
	$HitBox.damaged.connect(take_damage)
	pass

func _process(_delta: float) -> void:
	pass
	
func take_damage(_damage: int) -> void:
	queue_free()
