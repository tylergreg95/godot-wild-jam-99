extends Node2D

@onready var camera_2d: Camera2D = $Camera2D
@onready var piece_spawner: Marker2D = $PieceSpawner


func _on_tower_manager_goal_completed() -> void:
	camera_2d.global_position.y -= 400
	piece_spawner.move_local_y(-400)
