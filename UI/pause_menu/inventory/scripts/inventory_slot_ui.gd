class_name InventorySlotUI extends Button

var slot_data: SlotData: set = set_slot_data

@onready var texture_rect: TextureRect = $ItemTextureRect
@onready var selected_texture_rect: TextureRect = $SelectedTextureRect
@onready var label: Label = $Label

func _ready() -> void:
	texture_rect.texture = null
	label.text = ""
	selected_texture_rect.visible = false
	focus_entered.connect(item_focused)
	focus_exited.connect(item_unfocused)
	pass
	
func set_slot_data(value: SlotData) -> void:
	slot_data = value
	if slot_data == null:
		return
	texture_rect.texture = slot_data.item_data.texture
	label.text = str(slot_data.quantity)
	pass
	
func item_focused() -> void:
	if slot_data == null:
		return
	PauseMenu.update_item_desc(slot_data.item_data.desc)
	selected_texture_rect.visible = true
	pass
	
func item_unfocused() -> void:
	PauseMenu.update_item_desc("")
	selected_texture_rect.visible = false
	pass
