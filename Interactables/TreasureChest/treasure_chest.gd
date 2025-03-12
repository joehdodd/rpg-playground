@tool
class_name TreasureChest extends Node2D

@export var item_data: ItemData: set = _set_item_data
@export var quantity: int = 1: set = _set_quantity

var is_open: bool = false

@onready var chest_sprite: Sprite2D = $ChestSprite
@onready var item_sprite: Sprite2D = $ItemSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var interact_area: Area2D = $Area2D

func _ready() -> void:
	_update_texture()
	if Engine.is_editor_hint():
		return
	interact_area.area_entered.connect(_on_area_enter)
	interact_area.area_exited.connect(_on_area_exit)
	pass

func _set_item_data(value: ItemData) -> void:
	item_data = value
	pass
	
func _set_quantity(value: int) -> void:
	quantity = value
	pass
	
func _update_texture() -> void:
	if item_data && item_sprite:
		item_sprite.texture = item_data.world_texture
	pass
	
func player_interact() -> void:
	if is_open == true:
		return
	is_open = true
	animation_player.play("open_chest")
	if item_data && quantity > 0:
			PlayerManager.INVENTORY_DATA.add_item(item_data, quantity)
	else:
		printerr("No items")
	pass
	
func _on_area_enter(_a: Area2D) -> void:
	PlayerManager.interact_pressed.connect(player_interact)
	pass
	
func _on_area_exit(_a: Area2D) -> void:
	PlayerManager.interact_pressed.disconnect(player_interact)
	pass
