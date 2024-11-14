extends Control

@onready var nav_mini: PanelContainer = $NavMini
@onready var nav_pleine: PanelContainer = $NavPleine
@onready var nav_window: PanelContainer = $NavWindow
var isNavOpened: bool
var styleBoxTexture: StyleBoxTexture = StyleBoxTexture.new()

func _process(_delta) -> void:
	#Check if the player has found any document
	if Globals.doc1 == true: %Doc1.text = "Journal de William - p.1"
	else: %Doc1.disabled = true
	if Globals.doc2 == true: %Doc2.text = "Journal de William - p.2"
	else: %Doc2.disabled = true
	if Globals.doc3 == true: %Doc3.text = "Journal de William - p.3"
	else: %Doc3.disabled = true
	
	if Input.is_action_just_pressed("navigation"):
		if isNavOpened == false: _on_nav_mini_bouton_pressed()
		else: _on_nav_pleine_bouton_pressed()

func unfocus():
	var isFocus = get_viewport().gui_get_focus_owner()
	if isFocus: isFocus.release_focus()

func _on_nav_mini_bouton_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(nav_mini, "position", Vector2(-15, 164), 0.2)
	tween.tween_property(nav_pleine, "position", Vector2(0, 0), 0.4)
	isNavOpened = true
	unfocus()

func _on_nav_pleine_bouton_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(nav_pleine, "position", Vector2(-101, 0), 0.4)
	tween.tween_property(nav_mini, "position", Vector2(0, 164), 0.2)
	isNavOpened = false
	%Label.text = ""
	unfocus()
	_on_nav_window_bouton_pressed()

func _on_nav_window_bouton_pressed() -> void:
	%Notes.visible = false
	%Documents.visible = false
	var tween = get_tree().create_tween()
	tween.tween_property(nav_window, "position", Vector2(103, 360), 0.4)
	unfocus()

func _on_notes_bouton_pressed() -> void:
	%Notes.visible = true
	%Documents.visible = false
	
	%NotesBouton.add_theme_color_override("icon_normal_color", Color.WHITE)
	%DocsBouton.add_theme_color_override("icon_normal_color", Color("#ee9c31"))
	%InventaireBouton.add_theme_color_override("icon_normal_color", Color("#ee9c31"))
	%MapBouton.add_theme_color_override("icon_normal_color", Color("#ee9c31"))
	
	var tween = get_tree().create_tween()
	tween.tween_property(nav_window, "position", Vector2(103, 6.5), 0.4)

func _on_docs_bouton_pressed() -> void:
	%Notes.visible = false
	%Documents.visible = true
	
	%Label.text = ""
	%Lecture.remove_theme_stylebox_override("panel")
	
	%NotesBouton.add_theme_color_override("icon_normal_color", Color("#ee9c31"))
	%DocsBouton.add_theme_color_override("icon_normal_color", Color.WHITE)
	%InventaireBouton.add_theme_color_override("icon_normal_color", Color("#ee9c31"))
	%MapBouton.add_theme_color_override("icon_normal_color", Color("#ee9c31"))
	
	var tween = get_tree().create_tween()
	tween.tween_property(nav_window, "position", Vector2(103, 6.5), 0.7)

func _on_inventaire_bouton_pressed() -> void:
	pass # Replace with function body.


func _on_map_bouton_pressed() -> void:
	pass # Replace with function body.


func _on_doc_1_pressed() -> void:
	if Globals.doc1 == true:
		%Label.text = tr("JOURNAL_1")
		
		styleBoxTexture.texture = preload("res://Assets/UI/feuille.png")
		%Lecture.add_theme_stylebox_override("panel", styleBoxTexture)

func _on_doc_2_pressed() -> void:
	if Globals.doc2 == true:
		%Label.text = tr("JOURNAL_2")

func _on_doc_3_pressed() -> void:
	if Globals.doc3 == true:
		%Label.text = tr("JOURNAL_3")
