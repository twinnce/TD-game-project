extends HBoxContainer

@onready var _hover_player: AudioStreamPlayer = %HoverButtonPlayer
@onready var _pressed_player: AudioStreamPlayer = %PressedButtonPlayer

@onready var prev_button: Button = $PrevButton
@onready var next_button: Button = $NextButton
@onready var display_mode_label: Label = $DisplayModeLabel

# Список режимов экрана: системные параметры + ключ локализации из вашей таблицы
const DISPLAY_MODES = [
	{
		"mode": DisplayServer.WINDOW_MODE_WINDOWED,
		"borderless": false,
		"key": "UI_WINDOWED"
	},
	{
		"mode": DisplayServer.WINDOW_MODE_FULLSCREEN,
		"borderless": false,
		"key": "UI_FULLSCREEN"
	},
	{
		"mode": DisplayServer.WINDOW_MODE_WINDOWED,
		"borderless": true,
		"key": "UI_BORDERLESS"
	}
]

var current_index: int = 0

func _ready() -> void:
	prev_button.mouse_entered.connect(_on_mouse_hover)
	next_button.mouse_entered.connect(_on_mouse_hover)
	
	prev_button.pressed.connect(_on_prev_pressed)
	next_button.pressed.connect(_on_next_pressed)
	LocalizationManager.language_changed.connect(update_ui)
	update_ui()

func _on_mouse_hover() -> void:
	_hover_player.play()

func _on_prev_pressed() -> void:
	_pressed_player.play()
	current_index = (current_index - 1 + DISPLAY_MODES.size()) % DISPLAY_MODES.size()
	apply_display_mode()

func _on_next_pressed() -> void:
	_pressed_player.play()
	current_index = (current_index + 1) % DISPLAY_MODES.size()
	apply_display_mode()

func apply_display_mode() -> void:
	var mode_data = DISPLAY_MODES[current_index]
	
	# Применяем оконный режим и рамку через системный DisplayServer
	DisplayServer.window_set_mode(mode_data["mode"])
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, mode_data["borderless"])
	
	update_ui()

func update_ui() -> void:
	var mode_data = DISPLAY_MODES[current_index]
	# Текст берется из вашей CSV-таблицы по ключу и автоматически переводится
	display_mode_label.text = tr(mode_data["key"])
