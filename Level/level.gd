extends Node2D

@onready var camera_2d: Camera2D = $Camera2D
@onready var piece_spawner: Marker2D = $PieceSpawner


func _on_tower_manager_goal_completed() -> void:
	#camera_2d.global_position.y -= 400
	var camera_tween: Tween = get_tree().create_tween()
	camera_tween.tween_property(camera_2d, "global_position", camera_2d.global_position + Vector2(0, -400), 1.0)
	camera_tween.play()
	piece_spawner.move_local_y(-400)
