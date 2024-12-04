extends Node2D

@onready var scene_transition = get_tree().get_first_node_in_group("transition").get_child(1)
@onready var cinematique: Node2D = $Cinematique
@onready var collines_fond: Sprite2D = $Cinematique/Fond/CollinesFond
@onready var collines: Sprite2D = $Cinematique/Fond/Collines
@onready var collines_front: Sprite2D = $Cinematique/Fond/CollinesFront
@onready var abres_front: Sprite2D = $Cinematique/Fond/AbresFront
@onready var front: Node2D = $Cinematique/Front
@onready var texte_cinematique: Control = $Control/TexteCinematique
@onready var dialogues_cinematiques: DialoguesCinematiques = $Control/DialoguesCinematiques

var textSpeed: float

func _ready() -> void:
	scene_transition.play("fade_out")
	await get_tree().create_timer(3).timeout
	texte_cinematique.activate()

func _process(_delta) -> void:
	for sprite in $Cinematique/Fond.get_children():
		if sprite.position.x == 0:
			collines_fond.position.x = -640
			collines.position.x = -1572
			collines_front.position.x = -2684
			abres_front.position.x = -3587
			var tween = create_tween()
			for sprite2 in $Cinematique/Fond.get_children():
				tween.set_parallel().tween_property(sprite2, "position:x", 0, 10)

func _on_tremblements_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(front, "position:y", randi_range(-5, 2), 0.1)
	tween.chain().tween_property(front, "position:y", randi_range(-5, 0), 0.1)
	tween.chain().tween_property(front, "position:y", randi_range(-5, 1), 0.1)
	tween.chain().tween_property(front, "position:y", randi_range(-5, 2), 0.1)
	tween.chain().tween_property(front, "position:y", 0, 0.1)
	$Cinematique/Tremblements.wait_time = randf_range(1.0, 6.0)

func _on_texte_cinematique_dialogue_finished() -> void:
	texte_cinematique.queue_free()
	scene_transition.get_parent().get_child(0).color.a = 255
	scene_transition.play("fade_out")
	var tween = create_tween()
	for sprite in $Cinematique/Fond.get_children():
		tween.set_parallel().tween_property(sprite, "position:x", 0, 10)
	cinematique.visible = true
	await get_tree().create_timer(3).timeout
	dialogues_cinematiques.activate()

func _on_dialogues_cinematiques_dialogue_finished() -> void:
	await get_tree().create_timer(1).timeout
	scene_transition.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	#get_tree().change_scene_to_file("res://Scenes/Cimetiere.tscn")
