extends Control

@onready var play_again_button: TextureButton = $VBoxContainer/PlayAgainButton
@onready var main_menu_button: TextureButton = $VBoxContainer/MainMenuButton
@onready var hover_bloop: AudioStreamPlayer = $HoverBloop
@onready var score_label: Label = $VBoxContainer/ScoreLabel

var main_menu_scene: PackedScene = load("uid://c3ggxlnhdgik8")

func _ready() -> void:
	play_again_button.pivot_offset = play_again_button.size / 2.0
	main_menu_button.pivot_offset = main_menu_button.size / 2.0

func _on_play_again_button_mouse_entered() -> void:
	if play_again_button.disabled:
		return
	hover_bloop.play()
	var play_again_button_scale_tween: Tween = get_tree().create_tween()
	play_again_button_scale_tween.tween_property(play_again_button, "scale", Vector2(1.1,1.1), .1)
	play_again_button_scale_tween.tween_property(play_again_button, "rotation_degrees", 5, .1)
	play_again_button_scale_tween.chain().tween_property(play_again_button, "rotation_degrees", -5, .1)
	play_again_button_scale_tween.chain().tween_property(play_again_button, "rotation_degrees", 0, .1)
	play_again_button_scale_tween.tween_property(play_again_button, "scale", Vector2(1,1), .1)

func _on_main_menu_button_mouse_entered() -> void:
	if main_menu_button.disabled:
		return
	hover_bloop.play()
	var main_menu_button_scale_tween: Tween = get_tree().create_tween()
	main_menu_button_scale_tween.tween_property(main_menu_button, "scale", Vector2(1.1,1.1), .1)
	main_menu_button_scale_tween.tween_property(main_menu_button, "rotation_degrees", 5, .1)
	main_menu_button_scale_tween.chain().tween_property(main_menu_button, "rotation_degrees", -5, .1)
	main_menu_button_scale_tween.chain().tween_property(main_menu_button, "rotation_degrees", 0, .1)
	main_menu_button_scale_tween.chain().tween_property(main_menu_button, "scale", Vector2(1,1), .1)


func _on_play_again_button_pressed() -> void:
	play_again_button.disabled = true
	main_menu_button.disabled = true
	get_tree().reload_current_scene()


func _on_main_menu_button_pressed() -> void:
	play_again_button.disabled = true
	main_menu_button.disabled = true
	get_tree().change_scene_to_packed(main_menu_scene)

func set_score_text(score: float) -> void:
	score_label.text = "SCORE: " + "%.0f" % score
