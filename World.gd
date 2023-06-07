extends Node

signal volume_changed_signal

@onready var main_menu = $"Main Menu"
@onready var main_game = $TestingArea

var _main_menu_bus
var _temp_game_bus

# Called when the node enters the scene tree for the first time.
func _ready():
	volume_changed_signal.connect(volume_changed)
	_main_menu_bus = main_menu.AudioServer.get_bus_index("Master")
	_temp_game_bus = main_game.AudioServer.get_bus_index("Master")


func volume_changed(value):
	print("Het werkt :)")
	var test_value = linear_to_deb(value)
	print(test_value)
	main_menu.AudioServer.set_bus_volume_db(_main_menu_bus, test_value * 0.05)
	main_game.AudioServer.set_bus_volume_db(_temp_game_bus, test_value * 0.05)
