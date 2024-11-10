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
	if fenetre == true && Globals.left == false: indice.visible = false
	elif fenetre == true: indice.visible = true
	
	if porteCuisine == true && Globals.top == false: indice.visible = false
	elif porteCuisine == true : indice.visible = true
	
	if Input.is_action_just_pressed("Interaction") && indice.visible == true:
		if porteCuisine == true: print("cuisine")
		if fenetre == true: $Control.visible = true

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

func _on_button_pressed() -> void:
	$Control.visible = false
	$Fenetre.queue_free()
	$RideauBack1.queue_free()
	$RideauBack2.visible = true
	$RideauFront1.queue_free()
	$RideauFront2.visible = true
	await get_tree().create_timer(0.1).timeout
	$RideauBack2.queue_free()
	$RideauBack3.visible = true
	$RideauFront2.queue_free()
	$RideauFront3.visible = true
	await get_tree().create_timer(0.1).timeout
	$RideauBack3.queue_free()
	$RideauFront3.queue_free()

func _on_button_2_pressed() -> void:
	$Control.visible = false
