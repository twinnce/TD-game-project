extends Node

# Сигнал, который оповещает всю игру об изменении языка
signal language_changed

const CONFIG_PATH := "user://settings.cfg"

func _ready() -> void:
	load_language()

# Установка языка с последующим сохранением и оповещением элементов UI
func set_language(locale: String) -> void:
	TranslationServer.set_locale(locale)
	save_language()
	language_changed.emit()

# Сохранение текущей локали в конфигурационный файл
func save_language() -> void:
	var config := ConfigFile.new()
	config.set_value("settings", "locale", TranslationServer.get_locale())
	config.save(CONFIG_PATH)

# Загрузка локали из файла при запуске игры
func load_language() -> void:
	var config := ConfigFile.new()
	
	if config.load(CONFIG_PATH) == OK:
		var saved_locale = config.get_value("settings", "locale", "")
		if saved_locale != "":
			TranslationServer.set_locale(saved_locale)
			return

	# Если файла сохранения нет или ключа в нем не нашлось,
	# определяем язык по операционной системе пользователя
	var system_locale = OS.get_locale().to_lower()
	if system_locale.begins_with("ru"):
		TranslationServer.set_locale("ru")
	else:
		TranslationServer.set_locale("en")
