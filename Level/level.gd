extends Node2D
class_name Level

@onready var camera_2d: Camera2D = $Camera2D
@onready var piece_spawner: PieceSpawner = $PieceSpawner
@onready var screen_transition: ColorRect = $CanvasLayer/ScreenTransition
@onready var score_text: Label = $CanvasLayer/ScoreText
@onready var tower_manager: TowerManager = $TowerManager
@onready var game_timer: Timer = $GameTimer
@onready var time_text: Label = $CanvasLayer/TimeText
@onready var game_over: AudioStreamPlayer = $GameOver
@onready var level_music: AudioStreamPlayer = $LevelMusic
@onready var game_over_ui: Control = $CanvasLayer/GameOverUI


var current_score: float = 0
var level_in_progress: bool = false

func _ready() -> void:
	var screen_transition_tween: Tween = get_tree().create_tween()
	screen_transition_tween.tween_property(screen_transition, "color", Color(0,0,0,0), 1)
	screen_transition_tween.tween_callback(start_level_timer)
	screen_transition_tween.tween_callback(start_level)
	screen_transition_tween.play()
	

func _process(delta: float) -> void:
	if(not game_timer.is_stopped()):
		time_text.text = "%.1f" % game_timer.time_left

func start_level() -> void:
	level_in_progress = true
	piece_spawner.spawn_tower_piece()

func start_level_timer() -> void:
	game_timer.start()

func _on_tower_manager_goal_completed() -> void:
	var camera_tween: Tween = get_tree().create_tween()
	camera_tween.tween_property(camera_2d, "global_position", camera_2d.global_position + Vector2(0, -400), 1.0)
	camera_tween.play()
	piece_spawner.move_local_y(-400)
	var music_tween: Tween = get_tree().create_tween()
	music_tween.tween_property(level_music, "volume_db", -18.0, .5)
	music_tween.chain().tween_property(level_music, "volume_db", -10.0, 1)
	increase_timer_remaining()

func increase_timer_remaining() -> void:
	game_timer.start(game_timer.time_left + 60.0)

func _on_fetch_score_timer_timeout() -> void:
	var new_score: float = -tower_manager.get_highest_piece_value()
	if new_score == current_score:
		return
	var score_tween: Tween = get_tree().create_tween()
	score_tween.tween_property(self, "current_score" ,new_score, .5)
	score_tween.tween_method(func(val): score_text.text = str("%.0f" % float(val)), current_score, new_score, .5)


func _on_game_timer_timeout() -> void:
	game_over.play()
	level_in_progress = false
	game_over_ui.set_score_text(current_score)
	game_over_ui.visible = true
