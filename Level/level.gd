extends Node2D

@onready var camera_2d: Camera2D = $Camera2D
@onready var piece_spawner: Marker2D = $PieceSpawner
@onready var screen_transition: ColorRect = $CanvasLayer/ScreenTransition
@onready var score_text: Label = $CanvasLayer/ScoreText
@onready var tower_manager: TowerManager = $TowerManager

var current_score: float = 0

func _ready() -> void:
	var screen_transition_tween: Tween = get_tree().create_tween()
	screen_transition_tween.tween_property(screen_transition, "color", Color(0,0,0,0), 1)

func _on_tower_manager_goal_completed() -> void:
	var camera_tween: Tween = get_tree().create_tween()
	camera_tween.tween_property(camera_2d, "global_position", camera_2d.global_position + Vector2(0, -400), 1.0)
	camera_tween.play()
	piece_spawner.move_local_y(-400)


func _on_fetch_score_timer_timeout() -> void:
	var new_score: float = -tower_manager.get_highest_piece_value()
	if new_score == current_score:
		return
	var score_tween: Tween = get_tree().create_tween()
	score_tween.tween_property(self, "current_score" ,new_score, .5)
	score_tween.tween_method(func(val): score_text.text = str("%.0f" % float(val)), current_score, new_score, .5)
