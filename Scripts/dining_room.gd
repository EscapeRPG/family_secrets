extends Node2D

@onready var bastian: CharacterBody2D = $Bastian
@onready var bastianAnimation: AnimatedSprite2D = $Bastian/Animation
@onready var indice: Sprite2D = $Bastian/%Indice

var porteCuisine: bool = false
var fenetre: bool = false

func _ready() -> void:
	if Globals.previousLocation == "hall":
		bastian.position = Vector2(518, 240)
		bastianAnimation.play("idleg")
	else:
		bastian.position = Vector2(174, 152)
		bastianAnimation.play("idled")
		
	Globals.previousLocation = "diningRoom"

func _process(_delta: float) -> void:
	if fenetre && !Globals.left: indice.visible = false
	elif fenetre: indice.visible = true
	
	if porteCuisine && !Globals.top: indice.visible = false
	elif porteCuisine: indice.visible = true
	
	if Input.is_action_just_pressed("interaction") && indice.visible == true:
		if porteCuisine: $PorteCuisine/CanvasLayer/Dialogues.activate()
		if fenetre: $Fenetre/CanvasLayer/Dialogues.activate()

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
	
func _on_choice_event_choix_1() -> void:
	$CanvasLayer/ChoiceEvent.deactivate()
	$FenetreBack/FenetreAnimation.play()
	$FenetreFront/FenetreAnimation2.play()
	await get_tree().create_timer(0.3).timeout
	$Fenetre.queue_free()
	$FenetreBack.queue_free()
	$FenetreFront.queue_free()

func _on_choice_event_choix_2() -> void:
	$CanvasLayer/ChoiceEvent.deactivate()

func _on_dialogues_dialogue_finished() -> void:
	$CanvasLayer/ChoiceEvent.activate()
