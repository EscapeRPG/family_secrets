extends Node2D

@onready var scene_transition = get_tree().get_first_node_in_group("transition").get_child(1)
@onready var bastian: CharacterBody2D = $Bastian
@onready var bastianAnimation: AnimatedSprite2D = $Bastian/Animation
@onready var indice: Sprite2D = $Bastian/%Indice
@onready var empreintesNode: Area2D = $Empreintes
@onready var fenetreNode: Area2D = $Fenetre
@onready var table_2: Sprite2D = $Table/Table2
@onready var dialogues_cuisine: Dialogues = $CanvasLayer/DialoguesCuisine
@onready var choice_event_fenetre: ChoiceEvent = $CanvasLayer/ChoiceEventFenetre
@onready var dialogues_fenetre: Dialogues = $CanvasLayer/DialoguesFenetre
@onready var dialogues_empreintes: Dialogues = $CanvasLayer/DialoguesEmpreintes
@onready var fenetre_animation: AnimatedSprite2D = $Fenetre/FenetreBack/FenetreAnimation
@onready var fenetre_animation_2: AnimatedSprite2D = $Fenetre/FenetreFront/FenetreAnimation2

var porteCuisine: bool = false
var fenetre: bool = false
var empreintes: bool = false

func _ready() -> void:
	scene_transition.get_parent().get_child(0).color.a = 255
	scene_transition.play("fade_out")
	
	if Globals.data["previousLocation"] == "Hall":
		bastian.position = Vector2(518, 240)
		bastianAnimation.play("idleg")
	else:
		bastian.position = Vector2(174, 152)
		bastianAnimation.play("idled")
	
	if !Globals.data["nuit"]:
		$NightFilter.queue_free()
		$NightLights.queue_free()
	else:
		$DayLights.queue_free()
	
	if !Globals.data["intrusion"]:
		empreintesNode.queue_free()
		fenetreNode.queue_free()
		table_2.texture = load("res://Assets/Manoir/DiningRoom/Table.png")
		
	Globals.data["actualLocation"] = "DiningRoom"

func _process(_delta: float) -> void:
	if fenetre && Globals.data["leftright"] == "right": indice.visible = false
	elif fenetre: indice.visible = true
	
	if porteCuisine && Globals.data["updown"] == "down": indice.visible = false
	elif porteCuisine: indice.visible = true
	
	if Input.is_action_just_released("interaction") && indice.visible == true:
		if porteCuisine:
			dialogues_cuisine.activate()
			Globals.data["previousLocation"] = "DiningRoom"
			#scene_transition.play("fade_in")
			#await get_tree().create_timer(0.5).timeout
			#get_tree().change_scene_to_file("res://Scenes/Cuisine.tscn")
		if fenetre: dialogues_fenetre.activate()
		if empreintes: dialogues_empreintes.activate()
	
func _on_choice_event_fenetre_choix_1() -> void:
	choice_event_fenetre.deactivate()
	fenetre_animation.play()
	fenetre_animation_2.play()
	await get_tree().create_timer(0.3).timeout
	fenetreNode.queue_free()

func _on_choice_event_fenetre_choix_2() -> void:
	choice_event_fenetre.deactivate()

func _on_dialogues_fenetre_dialogue_finished() -> void:
	choice_event_fenetre.activate()

func _on_porte_cuisine_body_entered(body: Node2D) -> void:
	if body == bastian:
		indice.visible = true
		porteCuisine = true

func _on_porte_cuisine_body_exited(_body: Node2D) -> void:
	indice.visible = false
	porteCuisine = false

func _on_fenetre_body_entered(body: Node2D) -> void:
	if body == bastian:
		indice.visible = true
		fenetre = true

func _on_fenetre_body_exited(_body: Node2D) -> void:
	indice.visible = false
	fenetre = false

func _on_empreintes_body_entered(body: Node2D) -> void:
	if body == bastian:
		indice.visible = true
		empreintes = true

func _on_empreintes_body_exited(_body: Node2D) -> void:
	indice.visible = false
	empreintes = false
