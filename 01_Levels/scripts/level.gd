class_name Level extends Node2D

func _ready() -> void:
	self.y_sort_enabled = true
	PlayerManager.set_as_parent(self)
	LevelManager.level_load_started.connect(_free_player)
	
func _free_player() -> void:
	PlayerManager.unparent_player(self)
