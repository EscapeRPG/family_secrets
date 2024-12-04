extends Control

class_name ChoiceEvent

signal choix_1
signal choix_2

@export var question: Array[String]
@export var boutonchoix1: Array[String]
@export var boutonchoix2: Array[String]

@onready var qst = get_tree().get_first_node_in_group("choice")
@onready var q = qst.get_node("EventWindow/MarginContainer/VBoxContainer/Question")
@onready var c1 = qst.get_node("%Choix1")
@onready var c2 = qst.get_node("%Choix2")
@onready var index = 0

var isActive: bool

func _process(_delta):
	if len(question) != index && isActive:
		q.text = tr(question[index])
		c1.text = tr(boutonchoix1[index])
		c2.text = tr(boutonchoix2[index])
	elif isActive: deactivate()

func activate():
	get_tree().paused = true
	index = 0
	qst.visible = true
	isActive = true

func deactivate():
	get_tree().paused = false
	qst.visible = false
	q.text = ""
	isActive = false
	
func _on_choix_1_pressed() -> void:
	choix_1.emit()

func _on_choix_2_pressed() -> void:
	choix_2.emit()
