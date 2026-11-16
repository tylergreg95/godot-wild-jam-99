extends Control

@onready var play_button: TextureButton = $VBoxContainer/PlayButton
@onready var quit_button: TextureButton = $VBoxContainer/QuitButton
@onready var hover_bloop: AudioStreamPlayer = $HoverBloop
@onready var scene_transition: ColorRect = $SceneTransition
@onready var play_button_press: AudioStreamPlayer = $PlayButtonPress


var level_scene: PackedScene = preload("uid://bh413x7bib4wk")

func _ready() -> void:
	play_button.pivot_offset = play_button.size / 2.0
	quit_button.pivot_offset = quit_button.size / 2.0

func _on_play_button_pressed() -> void:
	play_button_press.play()
	play_button.disabled = true
	quit_button.disabled = true
	var scene_transition_tween: Tween = get_tree().create_tween()
	scene_transition_tween.tween_property(scene_transition, "color", Color(0,0,0,1), 2.0).finished.connect(next_scene)
	

func next_scene() -> void:
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_packed(level_scene)

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_play_button_mouse_entered() -> void:
	if play_button.disabled:
		return
	hover_bloop.play()
	var play_button_scale_tween: Tween = get_tree().create_tween()
	play_button_scale_tween.tween_property(play_button, "scale", Vector2(1.1,1.1), .1)
	play_button_scale_tween.tween_property(play_button, "rotation_degrees", 5, .1)
	play_button_scale_tween.chain().tween_property(play_button, "rotation_degrees", -5, .1)
	play_button_scale_tween.chain().tween_property(play_button, "rotation_degrees", 0, .1)
	play_button_scale_tween.tween_property(play_button, "scale", Vector2(1,1), .1)


func _on_quit_button_mouse_entered() -> void:
	if quit_button.disabled:
		return
	hover_bloop.play()
	var quit_button_scale_tween: Tween = get_tree().create_tween()
	quit_button_scale_tween.tween_property(quit_button, "scale", Vector2(1.1,1.1), .1)
	quit_button_scale_tween.tween_property(quit_button, "rotation_degrees", 5, .1)
	quit_button_scale_tween.chain().tween_property(quit_button, "rotation_degrees", -5, .1)
	quit_button_scale_tween.chain().tween_property(quit_button, "rotation_degrees", 0, .1)
	quit_button_scale_tween.chain().tween_property(quit_button, "scale", Vector2(1,1), .1)
