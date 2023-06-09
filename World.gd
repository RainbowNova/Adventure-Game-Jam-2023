extends Node

var ch1_done
var ch2_done
var ch3_done
var ch4_done

@onready var main_menu = $"Main Menu"
@onready var main_game = $TestingArea
@onready var camera = main_game.get_node("Camera2D")

var _main_menu_bus
var _temp_game_bus


func _ready():
	ch1_done = false
	ch2_done = false
	ch3_done = false
	ch4_done = false
	
	remove_child(main_game)
	main_menu.connect("start_game", swap_to_game)
	main_game.connect("conversation_key", show_chapter)
	camera.enabled = false
	
	
func swap_to_game():
	add_child(main_game)
	main_game.show()
	remove_child(main_menu)
	camera.enabled = true
	
	
func show_chapter(conversation_key):
	var scene
	# Way of Flow
	if conversation_key == "intro_dialogue" and not ch1_done:
		ch1_done = true
		scene = load("res://Chapter1_scene.tscn")
	# Way of Feedback
	elif conversation_key == "testttt" and not ch2_done:
		ch2_done = true
		scene = load("res://Chapter2_scene.tscn")
		# Way of Continual Learning and Experimentation
	elif conversation_key == "testttt" and not ch3_done:
		ch3_done = true
		scene = load("res://Chapter3_scene.tscn")
		# Way of Tea
	elif conversation_key == "testttt" and not ch4_done:
		ch4_done = true
		scene = load("res://Chapter4_scene.tscn")
	else:
		return
	var test = scene.instantiate()
	add_child(test)
	
func volume_changed(value):
	print("Het werkt :)")
	print(value)
	_main_menu_bus = main_menu.AudioServer.get_bus_index("Master")
	_temp_game_bus = main_game.AudioServer.get_bus_index("Master")
	main_menu.AudioServer.set_bus_volume_db(_main_menu_bus, value * 0.05)
	main_game.AudioServer.set_bus_volume_db(_temp_game_bus, value * 0.05)
