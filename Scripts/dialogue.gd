extends Label

func _process(_delta: float) -> void:
	match text:
		"Bastian":
			self.self_modulate = Color.DARK_BLUE
			self.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_RIGHT)
		"Gaspard":
			self.self_modulate = Color.FOREST_GREEN
			self.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_LEFT)
