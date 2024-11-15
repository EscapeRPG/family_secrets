extends Label

func _process(_delta: float) -> void:
	match text:
		"Bastian":
			self.self_modulate = Color.RED
			self.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_RIGHT)
