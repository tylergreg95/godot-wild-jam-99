extends Marker2D

@export var tower_manager: TowerManager

var piece_scene: PackedScene = preload("uid://clvj0861e8vwb")
var piece_l_1_scene: PackedScene = preload("uid://cc28014unv7s0")
var piece_s_1_scene: PackedScene = preload("uid://b37kkkcpg7oei")
var piece_t_1_scene: PackedScene = preload("uid://dvt3y78vwvnw5")

var pieces: Array[PackedScene] = []
var sprite_index: int = 0

func _ready() -> void:
	pieces.append(piece_scene)
	#pieces.append(piece_l_1_scene)
	#pieces.append(piece_s_1_scene)
	#pieces.append(piece_t_1_scene)
	spawn_tower_piece()


func spawn_tower_piece() -> void:
	var piece_choice = randi_range(0, len(pieces) - 1)
	var instance: TowerPiece = pieces[piece_choice].instantiate()
	add_child.call_deferred(instance)
	instance.setup(sprite_index)
	sprite_index = (sprite_index + 1) % 8
	instance.piece_landed.connect(spawn_tower_piece)
	tower_manager.add_tower_piece(instance)
