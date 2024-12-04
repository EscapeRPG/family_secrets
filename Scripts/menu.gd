extends Control

@onready var scene_transition = get_tree().get_first_node_in_group("transition").get_child(1)
@onready var titre: Label = $Titre
@onready var next: Label = $Next
@onready var boutons: VBoxContainer = $Boutons
@onready var continuer: Button = $Boutons/Continuer
@onready var new: Button = $Boutons/New
@onready var options: Button = $Boutons/Options
@onready var quit: Button = $Boutons/Quit
@onready var options_panel: Control = $OptionsPanel

var titletimer: bool

func _ready():
	scene_transition.play("fade_out")
	var file = FileAccess.open("user://save.data", FileAccess.READ)
	if file:
		TranslationServer.set_locale(Globals.data["language"])
		next.text = tr("menunext")
		continuer.disabled = false

func _process(_delta: float) -> void:
	titre.text = tr("menutitre")
	continuer.text = tr("menucontinuer")
	new.text = tr("menunew")
	quit.text = tr("menuquit")
		
	if Input.is_action_just_released("interaction") && titletimer && !boutons.visible:
		next.queue_free()
		boutons.visible = true

func _on_timer_timeout() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(titre, "modulate:a", 1, 3)
	await tween.finished
	next.visible = true
	titletimer = true
	$Timer.queue_free()

func _on_continuer_pressed() -> void:
	var file = FileAccess.open("user://save.data", FileAccess.READ)
	var saved_data = file.get_var()
	Globals.data = saved_data
	file.close()
	scene_transition.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/" + Globals.data["actualLocation"] + ".tscn")

func _on_new_pressed() -> void:
	scene_transition.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/Introduction.tscn")

func _on_options_pressed() -> void:
	boutons.visible = false
	options_panel.visible = true

func _on_options_panel_back_button_pressed() -> void:
	boutons.visible = true
	options_panel.visible = false

func _on_quit_pressed() -> void:
	get_tree().quit()
