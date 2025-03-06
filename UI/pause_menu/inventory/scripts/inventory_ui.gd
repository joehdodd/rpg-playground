class_name InventoryUI extends Control

const INVENTORY_SLOT = preload("res://UI/InventorySlot.tscn")

@export var data: InventoryData
var focus_index: int = 0

func _ready() -> void:
	PauseMenu.shown.connect(update_inventory)
	PauseMenu.hidden.connect(clear_inventory)
	clear_inventory()
	data.changed.connect(on_inventory_changed)
	pass

func clear_inventory() -> void:
	for child in get_children():
		child.queue_free()
	pass

func update_inventory() -> void:
	for slot in data.slots:
		var new_slot = INVENTORY_SLOT.instantiate()
		add_child(new_slot)
		new_slot.slot_data = slot
		new_slot.focus_entered.connect(item_focused)
	get_child(0).grab_focus()
	pass
	
func item_focused() -> void:
	for i in get_child_count():
		if get_child(i).has_focus():
			focus_index = i
	pass

func on_inventory_changed() -> void:
	var index = focus_index
	clear_inventory()
	update_inventory()
	await get_tree().process_frame
	get_child(index).grab_focus
	pass
