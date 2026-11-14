extends RigidBody2D
class_name TowerPiece

signal piece_landed()

@export var launch_force: float = 6.5

var mouse_in_piece: bool = false
var piece_following_cursor: bool = false
var original_position: Vector2
var release_position: Vector2
var clickable: bool = true
var has_landed: bool = false
var atlas_rows: int = 4
var atlas_columns: int = 2
var atlas_sprite_size: int = 16

#func _ready() -> void:
	#var tile_choice: int = randi_range(0, 8)
	#for child in get_children():
		#if child is AnimatedSprite2D:
			#child.frame = tile_choice
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and piece_following_cursor:
		global_position = get_global_mouse_position()

func _on_mouse_entered() -> void:
	if not clickable:
		return
	mouse_in_piece = true

func _on_mouse_exited() -> void:
	mouse_in_piece = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click") and mouse_in_piece and not piece_following_cursor:
		clickable = false
		original_position = global_position
		#print(original_position)
		piece_following_cursor = true
	elif event.is_action_released("left_click") and piece_following_cursor:
		release_position = global_position
		#print(release_position)
		piece_following_cursor = false
		launch()

func launch() -> void:
	
	#var direction: Vector2 = release_position.direction_to(original_position)
	#var distance: float = release_position.distance_to(original_position)
	freeze = false
	#linear_velocity = direction * distance * launch_force
	#print(distance)
	pass

func setup(sprite_index: int):
	for child in get_children():
		if child is AnimatedSprite2D:
			child.frame = sprite_index

func _on_body_entered(body: Node) -> void:
	handle_body_entered(body)
		
func handle_body_entered(body: Node) -> void:
	print(body)
	if not has_landed:
		has_landed = true
		
		var tower_manager: TowerManager = get_tree().current_scene.find_child("TowerManager")
		
		if body is TowerPiece:
			reparent.call_deferred(body.get_parent(), true)

			
		else:
			reparent.call_deferred(body, true)

		tree_exiting.connect.call_deferred(tower_manager.remove_tower_piece.bind(self))
		
		
		piece_landed.emit()
