extends CanvasLayer

# NOTE: The scene (PlayerHud) this is attached to is automatically loaded
# This means that this scene __does not__ need to be a child of any parent
# This scene will be added automatically at runtime.

@onready var player_health_progress_bar: TextureProgressBar = $PlayerHealthProgressBar

func update_hp(_hit_points: int, _max_hp: int) -> void:
	player_health_progress_bar.value = _hit_points * 100 / _max_hp
	pass
