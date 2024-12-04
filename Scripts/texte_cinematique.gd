extends Control

class_name Texte_Cinematique

signal dialogue_finished

@export var nombre_dialogues: Array[String]
@onready var dial = get_tree().get_first_node_in_group("cinematique")
@onready var dialogue = dial.get_node("Label")
@onready var index = 0

var timerStarted
var timer := 0.5
var isActive: bool
var textSpeed: float
var hasShowed: bool = false

func _process(delta):
	if len(dialogue.text) != 0:
		textSpeed = (5.0 / len(dialogue.text))
	
	if len(nombre_dialogues) != index && isActive:
		dialogue.text = tr(nombre_dialogues[index])
		dialogue.visible_ratio += textSpeed*delta
		
		if dialogue.visible_ratio == 1 && timer <= 0 && !hasShowed:
			hasShowed = true
			nextLine()
			timer = 1
	elif isActive: deactivate()
	
	if timerStarted: timer -= delta

func nextLine():
	await get_tree().create_timer(3).timeout
	var tween = create_tween()
	await tween.tween_property(dial, "modulate:a", 0, 0.5).finished
	await get_tree().create_timer(1).timeout
	index += 1
	dialogue.visible_ratio = 0
	dial.modulate.a = 1
	hasShowed = false

func activate():
	index = 0
	dialogue.visible_ratio = 0
	dial.visible = true
	timer = 1
	timerStarted = true
	isActive = true

func deactivate():
	var tween = create_tween()
	await tween.tween_property(dial, "modulate:a", 0, 0.5).finished
	dial.visible = false
	dialogue.text = ""
	isActive = false
	dialogue_finished.emit()
