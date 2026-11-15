extends Control

var level_scene: PackedScene = preload("uid://bh413x7bib4wk")

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(level_scene)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
