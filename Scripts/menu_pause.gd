extends Control

@onready var scene_transition = get_tree().get_first_node_in_group("transition").get_child(1)
@onready var pause: PanelContainer = $Pause
@onready var options_panel: Control = $OptionsPanel

var isPauseMenuOn: bool

func _process(_delta: float) -> void:
	if Input.is_action_just_released("pause"):
		if !isPauseMenuOn:
			get_tree().paused = true
			self.visible = true
			isPauseMenuOn = true
		else:
			_on_reprendre_pressed()

func _on_reprendre_pressed() -> void:
	get_tree().paused = false
	isPauseMenuOn = false
	self.visible = false

func _on_sauvegarder_pressed() -> void:
	var file = FileAccess.open("user://save.data", FileAccess.WRITE)
	var data = Globals.data
	
	file.store_var(data)
	file.close()

func _on_charger_pressed() -> void:
	var file = FileAccess.open("user://save.data", FileAccess.READ)
	var saved_data = file.get_var()
	Globals.data = saved_data
	file.close()
	get_tree().paused = false
	scene_transition.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/" + Globals.data["actualLocation"] + ".tscn")

func _on_options_pressed() -> void:
	pause.visible = false
	options_panel.visible = true

func _on_options_panel_back_button_pressed() -> void:
	options_panel.visible = false
	pause.visible = true

func _on_quitter_pressed() -> void:
	get_tree().quit()
