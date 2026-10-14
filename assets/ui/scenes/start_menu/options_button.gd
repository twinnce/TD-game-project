extends Button

@onready var _hover_player: AudioStreamPlayer = %HoverButtonPlayer
@onready var _pressed_player: AudioStreamPlayer = %PressedButtonPlayer

func _ready() -> void:
	mouse_entered.connect(_on_mouse_hover)
	pressed.connect(_on_mouse_pressed)

func _on_mouse_hover() -> void:
	_hover_player.play()

func _on_mouse_pressed() -> void:
	disabled = true                # Отлючаем кнопку, чтобы ее нельзя было нажимать бесконечно 
	_pressed_player.play()         # Играем звук нажатия
	await _pressed_player.finished # Ждем окончания звука
	
	# Переключаемся на настройки
	get_tree().change_scene_to_file("res://assets/ui/scenes/options_menu/options_menu.tscn")
