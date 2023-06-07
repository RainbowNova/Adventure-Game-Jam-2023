extends MarginContainer

var game_scene = preload("res://TestingArea.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_menu_button_start_game_pressed():
	get_tree().get_root().add_child(game_scene)
	get_node("/root/Main Menu").queue_free()

func _on_menu_button_credits_pressed():
	pass # Replace with function body.


func _on_menu_button_quit_game_pressed():
	pass # Replace with function body.


func _on_h_slider_value_changed(value):
	var _bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(_bus, linear_to_db(value) * 0.25)
