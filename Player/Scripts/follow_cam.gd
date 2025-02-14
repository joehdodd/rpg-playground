extends Camera2D

@export var tilemap: TileMapLayer

func _ready() -> void:
	var map_rect = tilemap.get_used_rect()
	var map_size = tilemap.rendering_quadrant_size
	var map_size_pixels = map_rect.size * map_size
	limit_right = map_size_pixels.x
	limit_bottom = map_size_pixels.y
