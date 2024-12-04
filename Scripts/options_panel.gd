extends Control

signal back_button_pressed

@onready var controls: Control = $MarginContainer/TextureRect/MarginContainer/TabContainer/Controls
@onready var langues: Control = $MarginContainer/TextureRect/MarginContainer/TabContainer/Langues

func _process(_delta: float) -> void:
	controls.name = tr("controls")
	%ControlsLabel.text = tr("controlslabel")
	langues.name = tr("language")
	%Language.text = tr("selectlanguage")
	%BackButton.text = tr("backbutton")
	
func _on_back_button_pressed() -> void:
	back_button_pressed.emit()

func _on_option_button_item_selected(index: int) -> void:
	if index == 0:
		TranslationServer.set_locale("fr")
		Globals.data["language"] = "fr"
	if index == 1:
		TranslationServer.set_locale("en")
		Globals.data["language"] = "en"
