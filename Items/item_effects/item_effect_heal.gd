class_name ItemEffectHeal extends ItemEffect

@export var heal_amount: int = 1

func use() -> void:
	PlayerManager.player.update_hp(heal_amount)
	pass
