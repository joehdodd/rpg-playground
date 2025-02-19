extends CanvasLayer

@onready var health_progress_bar: TextureProgressBar = $PlayerHealthProgressBar
@export var player: Player

func _ready() -> void:
	player.player_damaged.connect(update)
	update()
	pass 
	
func update() -> void:
	health_progress_bar.value = player.hit_points * 100 / player.max_hp
	pass
