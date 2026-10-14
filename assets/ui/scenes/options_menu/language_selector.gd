extends HBoxContainer

@onready var _hover_player: AudioStreamPlayer = %HoverButtonPlayer
@onready var _pressed_player: AudioStreamPlayer = %PressedButtonPlayer

@onready var prev_button: Button = $PrevButton
@onready var next_button: Button = $NextButton
@onready var language_label: Label = $LanguageLabel

const LANGUAGES = [
	{"code": "ru", "name": "Русский"},
	{"code": "en", "name": "English"}
]

var current_index: int = 0

func _ready() -> void:
	prev_button.mouse_entered.connect(_on_mouse_hover)
	next_button.mouse_entered.connect(_on_mouse_hover)
	
	prev_button.pressed.connect(_on_prev_pressed)
	next_button.pressed.connect(_on_next_pressed)
	
	# Подписываемся на глобальное изменение языка
	LocalizationManager.language_changed.connect(_on_language_changed)
	
	# Синхронизируем индекс при старте
	sync_index_with_current_locale()
	update_ui()

func _on_mouse_hover() -> void:
	_hover_player.play()

func _on_prev_pressed() -> void:
	_pressed_player.play()
	current_index = (current_index - 1 + LANGUAGES.size()) % LANGUAGES.size()
	apply_language()

func _on_next_pressed() -> void:
	_pressed_player.play()
	current_index = (current_index + 1) % LANGUAGES.size()
	apply_language()

func apply_language() -> void:
	var lang_data = LANGUAGES[current_index]
	# Меняем язык глобально через менеджер (он сам вызовет сигнал)
	LocalizationManager.set_language(lang_data["code"])

# Вызывается автоматически, когда язык меняется в игре
func _on_language_changed() -> void:
	sync_index_with_current_locale()
	update_ui()

# Находит правильный индекс по текущей локали движка
func sync_index_with_current_locale() -> void:
	var active_locale = TranslationServer.get_locale()
	for i in range(LANGUAGES.size()):
		if active_locale.begins_with(LANGUAGES[i]["code"]):
			current_index = i
			break

func update_ui() -> void:
	language_label.text = LANGUAGES[current_index]["name"]
