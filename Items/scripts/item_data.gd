class_name ItemData extends Resource

@export var name: String = ""
@export_multiline var desc: String = ""
@export var texture: Texture2D
@export var world_texture: Texture2D

@export_category("Item Use Effects")
@export var effects: Array[ItemEffect]
