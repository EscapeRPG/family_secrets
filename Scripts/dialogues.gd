extends Control

class_name Dialogues

signal dialogue_finished

@export var character_dialogue: Array[String]
@onready var dial = get_tree().get_first_node_in_group("dialogue")
@onready var character_name = dial.get_node("PanelContainer/MarginContainer/Bulle/MarginContainer/VBoxContainer/Name")
@onready var dialogue = dial.get_node("PanelContainer/MarginContainer/Bulle/MarginContainer/VBoxContainer/Dialogue")
@onready var index = 0

var timerStarted
var timer := 0.5
var isActive: bool
var textSpeed: float

func _process(delta):
	if len(dialogue.text) != 0:
		textSpeed = (40.0 / len(dialogue.text))
	
	if character_name.text == "Bastian":
		%PortraitBastian.visible = true
		%PortraitPNJ.visible = false
	else:
		%PortraitBastian.visible = false
		%PortraitPNJ.visible = true
		#%PortraitPNJ.texture = load("res://Assets/Characters/" + character_name.text + ".png")
	
	if len(character_dialogue) != index && isActive:
		character_name.text = tr(character_dialogue[index]).get_slice(":", 0)
		dialogue.text = tr(character_dialogue[index]).get_slice(":", 1)
		dialogue.visible_ratio += textSpeed*delta
		if Input.is_action_just_released("click") && dial.visible:
			if dialogue.visible_ratio < 1:
				dialogue.visible_ratio = 1
			elif timer <= 0:
				nextLine()
				timer = 0.5
	elif isActive:
		deactivate()
	
	if timerStarted:
		timer -= delta

func nextLine():
	index += 1
	dialogue.visible_ratio = 0

func activate():
	index = 0
	dialogue.visible_ratio = 0
	dial.visible = true
	timer = 0.5
	timerStarted = true
	isActive = true

func deactivate():
	dial.visible = false
	dialogue.text = ""
	isActive = false
	dialogue_finished.emit()
