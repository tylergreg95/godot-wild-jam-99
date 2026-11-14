extends Area2D

func set_height_label_text(height: float) -> void:
	$TextureRect/Label.text = "%.0f" % height + " m"
