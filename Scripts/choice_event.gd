extends Control

class_name ChoiceEvent

signal choix_1
signal choix_2

@export var question: Array[String]
@onready var qst = get_tree().get_first_node_in_group("choice")
@onready var q = qst.get_node("EventWindow/MarginContainer/VBoxContainer/Question")
@onready var index = 0

var timerStarted
var timer := 0.3
var isActive: bool

func _process(delta):
	if len(question) != index && isActive:
		q.text = tr(question[index])
	elif isActive:
		deactivate()
	
	if timerStarted:
		timer -= delta

func activate():
	index = 0
	qst.visible = true
	timer = 0.2
	timerStarted = true
	isActive = true

func deactivate():
	qst.visible = false
	q.text = ""
	isActive = false
	
func _on_choix_1_pressed() -> void:
	choix_1.emit()

func _on_choix_2_pressed() -> void:
	choix_2.emit()
