extends CanvasLayer

@onready var health_progress_bar: TextureProgressBar = $PlayerHealthProgressBar
	
#FIXME: https://youtu.be/XBJpmQYow5k?si=d1-n7ct6Epcm4UtK&t=1655
func update(_hurt_box) -> void:
	health_progress_bar.value = player.hit_points * 100 / player.max_hp
	pass
