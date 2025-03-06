class_name InventoryData extends Resource

@export var slots: Array[SlotData]

func _init() -> void:
	connect_slots()
	pass

func add_item(item: ItemData, count: int = 1) -> bool:
	for slot in slots:
		if slot:
			if slot.item_data == item:
				slot.quantity += count
				return true
	
	for i in slots.size():
		if slots[i] == null:
			var new_slot_data = SlotData.new()
			new_slot_data.item_data = item
			new_slot_data.quantity = count
			new_slot_data.changed.connect(slot_changed)
			slots[i] = new_slot_data
			return true
	print("inventory full")
	return false

func connect_slots() -> void:
	for slot in slots:
		if slot:
			slot.changed.connect(slot_changed)
	pass

func slot_changed() -> void:
	for slot in slots:
		if slot:
			if slot.quantity < 1:
				slot.changed.disconnect(slot_changed)
				var index = slots.find(slot)
				slots[index] = null
				emit_changed()
	pass
