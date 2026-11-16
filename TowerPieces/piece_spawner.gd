extends Marker2D

@export var tower_manager: TowerManager

@onready var line_2d: Line2D = $Line2D

var piece_scene: PackedScene = preload("uid://clvj0861e8vwb")
var piece_l_1_scene: PackedScene = preload("uid://cc28014unv7s0")
var piece_s_1_scene: PackedScene = preload("uid://b37kkkcpg7oei")
var piece_t_1_scene: PackedScene = preload("uid://dvt3y78vwvnw5")
var piece_st_1_scene: PackedScene = preload("uid://un0i0p5rkkwy")
var piece_u_1_scene: PackedScene = preload("uid://b1sag2yyn55hj")
var piece_h_1_scene: PackedScene = preload("uid://cmkw8kv5utwmq")

var pieces: Array[PackedScene] = []
var sprite_index: int = 0

func _ready() -> void:
	#pieces.append(piece_scene)
	pieces.append(piece_l_1_scene)
	pieces.append(piece_s_1_scene)
	pieces.append(piece_t_1_scene)
	pieces.append(piece_st_1_scene)
	pieces.append(piece_u_1_scene)
	pieces.append(piece_h_1_scene)
	spawn_tower_piece()


func spawn_tower_piece() -> void:
	var piece_choice = randi_range(0, len(pieces) - 1)
	var instance: TowerPiece = pieces[piece_choice].instantiate()
	add_child.call_deferred(instance)
	instance.setup(sprite_index)
	sprite_index = (sprite_index + 1) % 8
	instance.piece_landed.connect(spawn_tower_piece)
	instance.position_changed.connect(update_direction_line)
	tower_manager.add_tower_piece(instance)

func update_direction_line(piece_pos: Vector2):
	line_2d.set_point_position(1, global_position - piece_pos)
	var pull_distance = global_position.distance_to(piece_pos)
	var pull_color: Color = Color(pull_distance/282.5,0,0)
	line_2d.gradient.set_color(1, pull_color)
