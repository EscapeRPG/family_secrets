extends Control

class_name Dialogues

signal dialogue_finished

@export var character_dialogue: Array[String]
@onready var dial = get_tree().get_first_node_in_group("dialogue")
@onready var character_name = dial.get_node("PanelContainer/MarginContainer/Bulle/MarginContainer/VBoxContainer/Name")
@onready var dialogue = dial.get_node("PanelContainer/MarginContainer/Bulle/MarginContainer/VBoxContainer/HBoxContainer/Dialogue")
@onready var validation: Label = dial.get_node("PanelContainer/MarginContainer/Bulle/MarginContainer/VBoxContainer/HBoxContainer/Validation")
@onready var index = 0

var timerStarted
var timer := 0.5
var isActive: bool
var textSpeed: float

func _process(delta):
	if len(dialogue.text) != 0:
		textSpeed = (40.0 / len(dialogue.text))
	
	if character_name.text == "Bastian":
		%PortraitPNJ.visible = false
		%PortraitBastian.visible = true
	elif character_name.text != "":
		%PortraitPNJ.visible = true
		%PortraitBastian.visible = false
		%PortraitPNJ.texture = load("res://Assets/Characters/" + character_name.text + ".png")
	else:
		%PortraitPNJ.visible = false
		%PortraitBastian.visible = false
	
	if len(character_dialogue) != index && isActive:
		character_name.text = tr(character_dialogue[index]).get_slice(":", 0)
		dialogue.text = tr(character_dialogue[index]).get_slice(":", 1)
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
	get_tree().paused = true
	index = 0
	dialogue.visible_ratio = 0
	dial.visible = true
	timer = 1
	timerStarted = true
	isActive = true
	validation.visible = false

func deactivate():
	get_tree().paused = false
	character_name.text = ""
	dial.visible = false
	dialogue.text = ""
	isActive = false
	dialogue_finished.emit()
