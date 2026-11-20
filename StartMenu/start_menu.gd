extends Control

@export var title_tween_duration: float = 1.0
@export var title_tween_rotation_target: float = 5.0

@onready var play_button: TextureButton = $ButtonContainer/PlayButton
@onready var quit_button: TextureButton = $ButtonContainer/QuitButton
@onready var options_button: TextureButton = $ButtonContainer/OptionsButton
@onready var hover_bloop: AudioStreamPlayer = $HoverBloop
@onready var scene_transition: ColorRect = $SceneTransition
@onready var play_button_press: AudioStreamPlayer = $PlayButtonPress
@onready var close_options_button: TextureButton = $OptionsPanel/VBoxContainer/CloseOptionsButton
@onready var options_panel: TextureRect = $OptionsPanel
@onready var master_slider: HSlider = %MasterSlider
@onready var sounds_slider: HSlider = %SoundsSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var title: TextureRect = $Title
@onready var options_open: AudioStreamPlayer = $OptionsOpen
@onready var options_close: AudioStreamPlayer = $OptionsClose



var level_scene: PackedScene = preload("uid://bh413x7bib4wk")

func _ready() -> void:
	
	play_button.pivot_offset = play_button.size / 2.0
	quit_button.pivot_offset = quit_button.size / 2.0
	options_button.pivot_offset = options_button.size / 2.0
	title.pivot_offset = title.size / 2.0
	close_options_button.pivot_offset = close_options_button.size / 2.0
	master_slider.value = Config.get_bus_volume("master_volume")
	sounds_slider.value = Config.get_bus_volume("sounds_volume")
	music_slider.value = Config.get_bus_volume("music_volume")
	animate_title()
	
	
func animate_title() -> void:
	var title_tween_rotate: Tween = get_tree().create_tween()
	title_tween_rotate.tween_property(title, "rotation_degrees", title_tween_rotation_target, title_tween_duration)
	title_tween_rotate.chain().tween_property(title, "rotation_degrees", -title_tween_rotation_target, title_tween_duration)
	title_tween_rotate.chain().tween_property(title, "rotation_degrees", title_tween_rotation_target, title_tween_duration)
	title_tween_rotate.chain().tween_property(title, "rotation_degrees", -title_tween_rotation_target, title_tween_duration)
	
	var title_tween_scale: Tween = get_tree().create_tween()
	title_tween_scale.tween_property(title, "scale", Vector2(1.2,1.2), title_tween_duration * 2)
	title_tween_scale.chain().tween_property(title, "scale", Vector2(1.0,1.0), title_tween_duration * 2)
	title_tween_scale.tween_callback(animate_title)
	
	
	
	#title_tween.parallel()

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


func _on_options_button_mouse_entered() -> void:
	if options_button.disabled:
		return
	hover_bloop.play()
	var options_button_scale_tween: Tween = get_tree().create_tween()
	options_button_scale_tween.tween_property(options_button, "scale", Vector2(1.1,1.1), .1)
	options_button_scale_tween.tween_property(options_button, "rotation_degrees", 5, .1)
	options_button_scale_tween.chain().tween_property(options_button, "rotation_degrees", -5, .1)
	options_button_scale_tween.chain().tween_property(options_button, "rotation_degrees", 0, .1)
	options_button_scale_tween.chain().tween_property(options_button, "scale", Vector2(1,1), .1)


func _on_close_options_button_mouse_entered() -> void:
	if close_options_button.disabled:
		return
	hover_bloop.play()
	var close_options_button_scale_tween: Tween = get_tree().create_tween()
	close_options_button_scale_tween.tween_property(close_options_button, "scale", Vector2(1.1,1.1), .1)
	close_options_button_scale_tween.tween_property(close_options_button, "rotation_degrees", 5, .1)
	close_options_button_scale_tween.chain().tween_property(close_options_button, "rotation_degrees", -5, .1)
	close_options_button_scale_tween.chain().tween_property(close_options_button, "rotation_degrees", 0, .1)
	close_options_button_scale_tween.chain().tween_property(close_options_button, "scale", Vector2(1,1), .1)


func _on_close_options_button_pressed() -> void:
	options_close.play()
	options_panel.visible = false
	play_button.disabled = false
	options_button.disabled = false
	quit_button.disabled = false

func _on_options_button_pressed() -> void:
	options_open.play()
	options_panel.visible = true
	play_button.disabled = true
	options_button.disabled = true
	quit_button.disabled = true


func _on_master_slider_value_changed(value: float) -> void:
	Config.config.set_value("Player1", "master_volume", value)
	Config.save()
	Config.set_bus_volumes()


func _on_sounds_slider_value_changed(value: float) -> void:
	Config.config.set_value("Player1", "sounds_volume", value)
	Config.save()
	Config.set_bus_volumes()


func _on_music_slider_value_changed(value: float) -> void:
	Config.config.set_value("Player1", "music_volume", value)
	Config.save()
	Config.set_bus_volumes()
