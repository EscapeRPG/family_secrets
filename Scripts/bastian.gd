extends CharacterBody2D

const SPEED = 120.0

@onready var animation: AnimatedSprite2D = $Animation
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var point_light_2d_2: PointLight2D = $PointLight2D2

func _ready():
	if !Globals.data["torchlight"]:
		point_light_2d.queue_free()
		point_light_2d_2.queue_free()
	else:
		point_light_2d.visible = true
		point_light_2d_2.visible = true

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
	
	if Input.is_action_pressed("move_left") && !is_on_wall():
		animation.play("walkg")
		Globals.data["leftright"] = "left"
		if Globals.data["torchlight"]:
			point_light_2d.offset = Vector2(-95, -50)
			point_light_2d.scale.x = 1
			point_light_2d.rotation = 0
			point_light_2d_2.offset = Vector2(-95, -50)
			point_light_2d_2.scale.x = 1
			point_light_2d_2.rotation = 0
	elif Input.is_action_pressed("move_right") && !is_on_wall():
		animation.play("walkd")
		Globals.data["leftright"] = "right"
		if Globals.data["torchlight"]:
			point_light_2d.offset = Vector2(-95, -50)
			point_light_2d.scale.x = -1
			point_light_2d.rotation = 0
			point_light_2d_2.offset = Vector2(-95, -50)
			point_light_2d_2.scale.x = -1
			point_light_2d_2.rotation = 0
	elif Input.is_action_pressed("move_up") && !is_on_ceiling():
		animation.play("walkback")
		Globals.data["updown"] = "up"
		if Globals.data["torchlight"]:
			point_light_2d.offset = Vector2(-160, 75)
			point_light_2d.scale.x = 1
			point_light_2d.rotation_degrees = 115.5
			point_light_2d_2.offset = Vector2(-160, 75)
			point_light_2d_2.scale.x = 1
			point_light_2d_2.rotation_degrees = 115.5
	elif Input.is_action_pressed("move_down") && !is_on_floor():
		animation.play("walkfront")
		Globals.data["updown"] = "down"
		if Globals.data["torchlight"]:
			point_light_2d.offset = Vector2(10, 20)
			point_light_2d.scale.x = -1
			point_light_2d.rotation_degrees = 63.5
			point_light_2d_2.offset = Vector2(10, 20)
			point_light_2d_2.scale.x = -1
			point_light_2d_2.rotation_degrees = 63.5
	else:
		if Globals.data["leftright"] == "left":
			animation.play("idleg")
			if Globals.data["torchlight"]:
				point_light_2d.offset = Vector2(-95, -50)
				point_light_2d.scale.x = 1
				point_light_2d.rotation = 0
				point_light_2d_2.offset = Vector2(-95, -50)
				point_light_2d_2.scale.x = 1
				point_light_2d_2.rotation = 0
		elif Globals.data["leftright"] == "right":
			animation.play("idled")
			if Globals.data["torchlight"]:
				point_light_2d.offset = Vector2(-95, -50)
				point_light_2d.scale.x = -1
				point_light_2d.rotation = 0
				point_light_2d_2.offset = Vector2(-95, -50)
				point_light_2d_2.scale.x = -1
				point_light_2d_2.rotation = 0
	
	move_and_slide()
