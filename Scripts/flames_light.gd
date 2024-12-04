extends Node2D

@export var light_a: PointLight2D
@export var light_b: PointLight2D
@export_range(0.0, 1.8) var jitter_min_energy := 1.8

var progress = 0.0
var jitter_speed := 3.0

func _process(delta: float) -> void:
	progress += delta * jitter_speed
	if progress >= 1.0:
		progress -= 1.0
		jitter()

func jitter():
	light_a.scale = Vector2(randf_range(0.5, 0.6), randf_range(0.5, 0.6))
	light_b.scale = Vector2(randf_range(0.7, 0.9), randf_range(0.7, 0.9))
	
	light_a.energy = randf_range(jitter_min_energy, 2.0)
	light_b.energy = randf_range(0.2, 0.4)
