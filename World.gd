extends Node


@onready var main_menu = $"Main Menu"
@onready var main_game = $TestingArea
@onready var camera = main_game.get_node("Camera2D")

var _main_menu_bus
var _temp_game_bus


func _ready():
	remove_child(main_game)
	main_game.connect("test_button", show_chapter)
	$"Main Menu".connect("start_game", swap_to_game)
	
	camera.enabled = false
	
	
func swap_to_game():
	add_child(main_game)
	main_game.show()
	remove_child(main_menu)
	camera.enabled = true
	
	
func show_chapter():
	var scene = load("res://Chapter_scene_test.tscn")
	var test = scene.instantiate()
	add_child(test)
	
	
func volume_changed(value):
	print("Het werkt :)")
	print(value)
	_main_menu_bus = main_menu.AudioServer.get_bus_index("Master")
	_temp_game_bus = main_game.AudioServer.get_bus_index("Master")
	main_menu.AudioServer.set_bus_volume_db(_main_menu_bus, value * 0.05)
	main_game.AudioServer.set_bus_volume_db(_temp_game_bus, value * 0.05)
