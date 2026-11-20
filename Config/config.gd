extends Node

var config: ConfigFile = ConfigFile.new()
var err = config.load("user://settings.cfg")
var master_bus_name: String = "Master"
var music_bus_name: String = "Music"
var sounds_bus_name: String = "Sounds"
var master_bus_index: int
var sounds_bus_index: int
var music_bus_index: int

func _ready() -> void:
	if err != OK:
		return
	master_bus_index = AudioServer.get_bus_index(master_bus_name)
	music_bus_index = AudioServer.get_bus_index(music_bus_name)
	sounds_bus_index = AudioServer.get_bus_index(sounds_bus_name)
	set_bus_volumes()
	
func set_bus_volumes() -> void:
	var master_volume := 0.5
	var sounds_volume := 0.5
	var music_volume := 0.5
	for player in config.get_sections():
		master_volume = config.get_value(player, "master_volume")
		AudioServer.set_bus_volume_db(master_bus_index, linear_to_db(master_volume))
		sounds_volume = config.get_value(player, "sounds_volume")
		AudioServer.set_bus_volume_db(sounds_bus_index, linear_to_db(sounds_volume))
		music_volume = config.get_value(player, "music_volume")
		AudioServer.set_bus_volume_db(music_bus_index, linear_to_db(music_volume))
		
func save():
	config.save("user://settings.cfg")

func get_bus_volume(volume_setting: String) -> float:
	var volume: float = 0.5
	for player in config.get_sections():
		volume = config.get_value(player, volume_setting)
	return volume
