extends Control

func _ready() -> void:
	var system_locale = OS.get_locale() # Получаем язык операционной системы

	# Ставим язык операционной системы, если он поддерживается
	if system_locale.begins_with("ru"):
		TranslationServer.set_locale("ru")
	else: # В противном случае ставим английский по умолчанию
		TranslationServer.set_locale("en")
