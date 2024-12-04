extends Control

class_name DialoguesCinematiques

signal dialogue_finished

@export var character_dialogue: Array[String]
@onready var dial = get_tree().get_first_node_in_group("dialoguescinematiques")
@onready var dialogue: RichTextLabel = dial.get_node("HBoxContainer/Dialogue")
@onready var validation: Label = dial.get_node("HBoxContainer/Validation")
@onready var index = 0

var timerStarted
var timer := 0.5
var isActive: bool
var textSpeed: float

func _process(delta):
	if len(dialogue.text) != 0:
		textSpeed = (40.0 / len(dialogue.text))
	
	if len(character_dialogue) != index && isActive:
		dialogue.text = tr(character_dialogue[index])
		dialogue.visible_ratio += textSpeed*delta
		
		if dialogue.visible_ratio == 1 && timer <= 0: validation.visible = true
			
		if Input.is_action_just_released("interact_dialogues") && dial.visible && timer < 0.8:
			if dialogue.visible_ratio < 1: dialogue.visible_ratio = 1
			elif validation.visible:
				nextLine()
				timer = 1
	elif isActive: deactivate()
	
	if timerStarted: timer -= delta

func nextLine():
	index += 1
	dialogue.visible_ratio = 0
	validation.visible = false

func activate():
	index = 0
	dialogue.visible_ratio = 0
	dial.visible = true
	timer = 1
	timerStarted = true
	isActive = true
	validation.visible = false

func deactivate():
	dial.visible = false
	dialogue.text = ""
	isActive = false
	dialogue_finished.emit()
