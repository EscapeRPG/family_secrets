extends CharacterBody2D

const SPEED = 150.0
@onready var animation: AnimatedSprite2D = $Animation
	
func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
	
	if Input.is_action_just_pressed("move_left"):
		Globals.left = true
		Globals.right = false
	elif Input.is_action_just_pressed("move_right"):
		Globals.left = false
		Globals.right = true
	elif Input.is_action_just_pressed("move_up"):
		Globals.top = true
		Globals.down = false
	elif Input.is_action_just_pressed("move_down"):
		Globals.top = false
		Globals.down = true
	
	else:
		if Input.is_action_pressed("move_left") && !is_on_wall(): animation.play("walkg")
		elif Input.is_action_pressed("move_right") && !is_on_wall(): animation.play("walkd")
		elif Input.is_action_pressed("move_up") && !is_on_ceiling(): animation.play("walkback")
		elif Input.is_action_pressed("move_down") && !is_on_floor(): animation.play("walkfront")
		else:
			if Globals.left == true: animation.play("idleg")
			elif Globals.right == true: animation.play("idled")
	
	move_and_slide()
