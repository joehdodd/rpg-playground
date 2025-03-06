class_name InventoryData extends Resource

@export var slots: Array[SlotData]

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
			slots[i] = new_slot_data
			return true
	
	print("inventory full")
	return false
