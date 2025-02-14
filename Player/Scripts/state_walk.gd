class_name State_Walk extends PlayerState

@export var move_speed: float = 100.0
@onready var idle: PlayerState = $"../Idle"

# What happens when the player enters this tate?
func Enter() -> void:
	player.UpdateAnimation("walk")
	pass
	
# What happens when the player exit this tate?
func Exit() -> void:
	pass
	
func Process(_delta: float) -> PlayerState:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.UpdateAnimation("walk")
	return null
	
func Physics(_delta: float) -> PlayerState:
	return null
	
func HandleInput(_event: InputEvent) -> PlayerState:
	return null
