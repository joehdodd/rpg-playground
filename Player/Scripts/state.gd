class_name PlayerState extends Node

static var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# What happens when the player enters this tate?
func Enter() -> void:
	pass
	
# What happens when the player exit this tate?
func Exit() -> void:
	pass
	
func Process(_delta: float) -> PlayerState:
	return null
	
func Physics(_delta: float) -> PlayerState:
	return null
	
func HandleInput(_event: InputEvent) -> PlayerState:
	return null
