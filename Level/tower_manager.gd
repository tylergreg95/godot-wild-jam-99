extends Node
class_name TowerManager

signal goal_completed()

@export var height_goal_delta: float = 400
@export var tower_pieces_in_tower: Array[TowerPiece] = []

@onready var height_goal_complete: AudioStreamPlayer = $HeightGoalComplete
@onready var height_goal_complete_timer: Timer = $HeightGoalCompleteTimer


const X_OFFSET: float = 450.0

var current_height_goal: float = 0
var height_goal_area: PackedScene = preload("uid://ba1v7jol1ak3s")
var current_height_goal_instance: HeightGoal
var height_goal_complete_sound_pitch: float = 1.0


func _ready() -> void:
	current_height_goal_instance = create_next_height_goal()

func _process(delta: float) -> void:
	if not height_goal_complete_timer.is_stopped():
		current_height_goal_instance.update_progress_bar(height_goal_complete_timer.time_left)

func create_next_height_goal() -> Area2D:
	current_height_goal += height_goal_delta
	var next_goal: Area2D = height_goal_area.instantiate()
	next_goal.global_position = Vector2(X_OFFSET, -current_height_goal)
	add_child(next_goal)
	next_goal.body_entered.connect(handle_height_goal_entered)
	next_goal.body_exited.connect(handle_height_goal_exited)
	return next_goal

func handle_height_goal_entered(body: Node2D):
	if body is TowerPiece:
		if body.has_landed:
			if current_height_goal_instance.has_overlapping_bodies() and len(current_height_goal_instance.get_overlapping_bodies()) == 1:
				height_goal_complete_timer.start()

func handle_height_goal_exited(body: Node2D) -> void:
	if not current_height_goal_instance.has_overlapping_bodies():
		height_goal_complete_timer.stop()
		current_height_goal_instance.update_progress_bar(3)

func add_tower_piece(piece: TowerPiece) -> void:
	if tower_pieces_in_tower.has(piece):
		return
	
	tower_pieces_in_tower.append(piece)

func remove_tower_piece(piece: TowerPiece) -> void:
	if tower_pieces_in_tower.has(piece):
		var piece_index: int = tower_pieces_in_tower.find(piece)
		tower_pieces_in_tower.remove_at(piece_index)


func _on_height_goal_complete_timer_timeout() -> void:
	if current_height_goal_instance.has_overlapping_bodies():
		current_height_goal_instance.call_deferred("queue_free")
		var next_height_goal = create_next_height_goal()
		height_goal_complete.pitch_scale = height_goal_complete_sound_pitch
		height_goal_complete.play()
		height_goal_complete_sound_pitch += 0.1
		goal_completed.emit()
		freeze_current_tower() 
		current_height_goal_instance = next_height_goal

func freeze_current_tower() -> void:
	for tower_piece: TowerPiece in tower_pieces_in_tower:
		tower_piece.freeze = true

func get_highest_piece_value() -> float:
	var max_height = 0
	if len(tower_pieces_in_tower) <= 0:
		return 0
	for piece: TowerPiece in tower_pieces_in_tower:
		if not piece.has_landed:
			continue
		if piece.position.y < max_height:
			max_height = piece.position.y
	return max_height
	
