extends CharacterBody2D

const SPEED = 150.0
	
func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
	
	if Input.is_action_just_pressed("move_left"):
		Globals.left = true
		Globals.right = false
		Globals.top = false
		Globals.down = false
	elif Input.is_action_just_pressed("move_right"):
		Globals.left = false
		Globals.right = true
		Globals.top = false
		Globals.down = false
	elif Input.is_action_just_pressed("move_up"):
		Globals.top = true
		Globals.down = false
	elif Input.is_action_just_pressed("move_down"):
		Globals.top = false
		Globals.down = true
	
	else:
		if Input.is_action_pressed("move_left") && !is_on_wall():
			$AnimatedSprite2D.play("walkg")
		elif Input.is_action_pressed("move_right") && !is_on_wall():
			$AnimatedSprite2D.play("walkd")
		elif Input.is_action_pressed("move_up") && !is_on_ceiling():
			$AnimatedSprite2D.play("walkback")
		elif Input.is_action_pressed("move_down") && !is_on_floor():
			$AnimatedSprite2D.play("walkfront")
		else:
			if Globals.left == true:
				$AnimatedSprite2D.play("idleg")
			elif Globals.right == true:
				$AnimatedSprite2D.play("idled")
			elif Globals.top == true:
				$AnimatedSprite2D.play("idleback")
			else:
				$AnimatedSprite2D.play("idled")
	
	move_and_slide()
