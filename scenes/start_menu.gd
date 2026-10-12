extends Control

# Путь к сцене игры. Подставь свой: в панели файлов ПКМ по сцене → Copy Path.
const GAME_SCENE := "res://scenes/game.tscn"

@onready var play_button: Button = $HBoxContainer/PanelContainer/VBoxContainer/PlayButton
@onready var options_button: Button = $HBoxContainer/PanelContainer/VBoxContainer/OptionsButton
@onready var quit_button: Button = $HBoxContainer/PanelContainer/VBoxContainer/QuitButton
@onready var hover_player: AudioStreamPlayer = $HoverPlayer


func _ready() -> void:
	for button in [play_button, options_button, quit_button]:
		button.mouse_entered.connect(_on_button_hover)
	play_button.pressed.connect(_on_play_pressed)
	quit_button.pressed.connect(_on_quit_pressed)


func _on_button_hover() -> void:
	hover_player.play()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(GAME_SCENE)


func _on_quit_pressed() -> void:
	get_tree().quit()
