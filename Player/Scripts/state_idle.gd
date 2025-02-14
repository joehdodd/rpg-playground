class_name State_Idle extends PlayerState

@onready var walk: PlayerState = $"../Walk"

# What happens when the player enters this tate?
func Enter() -> void:
	player.UpdateAnimation("idle")
	pass
	
# What happens when the player exit this tate?
func Exit() -> void:
	pass
	
func Process(_delta: float) -> PlayerState:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null
	
func Physics(_delta: float) -> PlayerState:
	return null
	
func HandleInput(_event: InputEvent) -> PlayerState:
	return null
