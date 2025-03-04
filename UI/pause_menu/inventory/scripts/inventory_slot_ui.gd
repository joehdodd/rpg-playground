class_name InventorySlotUI extends TextureButton

var slot_data: SlotData: set = set_slot_data

@onready var texture_rect: TextureRect = $TextureRect 
@onready var label: Label = $Label

func _ready() -> void:
	texture_rect.texture = null
	label.text = ""
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
	pass
	
func item_unfocused() -> void:
	PauseMenu.update_item_desc("")
	pass
