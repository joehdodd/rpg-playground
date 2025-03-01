extends Node2D

const START_LEVEL: String = "res://01_Levels/Area_01/01_Home/Home.tscn"

@onready var button_new: Button = $CanvasLayer/Control/VBoxParent/VBoxChild/NewGame
@onready var button_cont: Button = $CanvasLayer/Control/VBoxParent/VBoxChild/Continue

func _ready() -> void:
	get_tree().paused = true
	PlayerManager.player.visible = false
	
	PlayerHud.visible = false
	PauseMenu.process_mode = Node.PROCESS_MODE_DISABLED
	
	setup_title_screen()
	
	LevelManager.level_load_started.connect(exit_title_screen)
	pass

func setup_title_screen() -> void:
	button_new.pressed.connect(start_game)
	button_cont.pressed.connect(load_game)
	button_new.grab_focus()
	pass

func start_game() -> void:
	LevelManager.load_new_level(START_LEVEL, "", Vector2.ZERO)
	
	await LevelManager.level_load_started
	
	PlayerManager.set_player_position(Vector2(40, 40))
	pass

func load_game() -> void:
	SaveManager.load_game()
	pass

func exit_title_screen() -> void:
	PlayerManager.player.visible = true
	PauseMenu.process_mode = Node.PROCESS_MODE_ALWAYS
	pass
