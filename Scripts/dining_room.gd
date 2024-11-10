extends Node2D

var porteCuisine = false
var fenetre = false
var oui
var non

func _ready() -> void:
	if Globals.previousLocation == "hall":
		$Bastian.position = Vector2(518, 240)
		$Bastian/AnimatedSprite2D.play("idleg")
	else:
		$Bastian.position = Vector2(174, 152)
		$Bastian/AnimatedSprite2D.play("idled")
		
	Globals.previousLocation = "diningRoom"

func _process(_delta: float) -> void:
	if fenetre == true && Globals.left == false: $Bastian/%Indice.visible = false
	elif fenetre == true: $Bastian/%Indice.visible = true
	
	if porteCuisine == true && Globals.top == false: $Bastian/%Indice.visible = false
	elif porteCuisine == true : $Bastian/%Indice.visible = true
	
	if Input.is_action_just_pressed("Interaction") && $Bastian/%Indice.visible == true:
		if porteCuisine == true: print("cuisine")
		if fenetre == true: $Control.visible = true

func _on_porte_cuisine_body_entered(body: Node2D) -> void:
	if body == $Bastian:
		$Bastian/%Indice.visible = true
		porteCuisine = true

func _on_porte_cuisine_body_exited(_body: Node2D) -> void:
	$Bastian/%Indice.visible = false
	porteCuisine = false

func _on_fenetre_body_entered(body: Node2D) -> void:
	if body == $Bastian && Globals.left == true:
		$Bastian/%Indice.visible = true
		fenetre = true

func _on_fenetre_body_exited(_body: Node2D) -> void:
	$Bastian/%Indice.visible = false
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
