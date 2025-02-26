extends CanvasLayer

# NOTE: The scene (PlayerHud) this is attached to is automatically loaded
# This means that this scene __does not__ need to be a child of any parent
# This scene will be added automatically at runtime.

@onready var player_health_progress_bar: TextureProgressBar = $PlayerHealthProgressBar
@onready var game_over: Control = $GameOver
@onready var continue_button: Button = $GameOver/VBoxContainer/ContinueButton
@onready var title_button: Button = $GameOver/VBoxContainer/TitleButton
@onready var animation_player: AnimationPlayer = $GameOver/AnimationPlayer

func _ready() -> void:
	hide_game_over_screen()
	continue_button.pressed.connect(load_game)
	title_button.pressed.connect(title_screen)
	LevelManager.level_load_started.connect(hide_game_over_screen)
	pass

func update_hp(_hit_points: int, _max_hp: int) -> void:
	player_health_progress_bar.value = _hit_points * 100 / _max_hp
	pass

func show_game_over_screen() -> void:
	game_over.visible = true
	game_over.mouse_filter = Control.MOUSE_FILTER_STOP
	
	var can_continue: bool = SaveManager.get_save_file() != null
	continue_button.visible = can_continue
	
	animation_player.play("show_game_over")
	await animation_player.animation_finished
	
	if can_continue == true: 
		continue_button.grab_focus()
	else:
		title_button.grab_focus()
	pass

func hide_game_over_screen() -> void:
	game_over.visible = false
	game_over.mouse_filter = Control.MOUSE_FILTER_IGNORE
	game_over.modulate = Color(1, 1, 1, 0)
	pass

func load_game() -> void:
	await fade_screen()
	SaveManager.load_game()
	pass

func title_screen() -> void:
	await fade_screen()
	LevelManager.load_new_level("res://World/world.tscn", "", Vector2.ZERO )
	pass

func fade_screen() -> bool:
	animation_player.play("fade_screen")
	await animation_player.animation_finished
	PlayerManager.player.revive_player()
	return true
