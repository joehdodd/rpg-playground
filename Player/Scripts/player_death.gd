class_name State_Death extends Player_State

@export var death_sound: AudioStream

@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

func _ready() -> void:
	pass
	
func init() -> void:
	pass

func enter() -> void:
	player.animation_player.play("death")
	audio.stream = death_sound
	audio.pitch_scale = 1.75
	audio.play()
	PlayerHud.show_game_over_screen()
	pass
	
func exit() -> void:
	pass
	
func process(_delta: float) -> Player_State:
	player.velocity = Vector2.ZERO
	return null
	
func physics(_delta: float) -> Player_State:
	return null
	
func handle_input(_event: InputEvent) -> Player_State:
	return null
