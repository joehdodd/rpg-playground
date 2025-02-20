extends CanvasLayer

@onready var health_progress_bar = $PlayerHealthProgressBar

func _ready():
	pass

func update(hit_points: int, max_hp: int) -> void:
	health_progress_bar.value = hit_points * 100 / max_hp
	pass
