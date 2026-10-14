extends Button

@onready var _hover_player: AudioStreamPlayer = %HoverButtonPlayer
@onready var _pressed_player: AudioStreamPlayer = %PressedButtonPlayer

func _ready() -> void:
	mouse_entered.connect(_on_mouse_hover)
	pressed.connect(_on_mouse_pressed)

func _on_mouse_hover() -> void:
	_hover_player.play()

func _on_mouse_pressed() -> void:
	_pressed_player.play()
