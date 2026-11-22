extends Area2D
class_name HeightGoal

@onready var progress_bar: TextureProgressBar = $ProgressBar


func update_progress_bar(time_left: float) -> void:
	progress_bar.value = 1.0 - (time_left / 3.0)
