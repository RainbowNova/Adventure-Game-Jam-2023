extends MarginContainer

var _main_menu_bus
var _temp_game_bus

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_menu_button_start_game_pressed():
	get_tree().change_scene_to_file("res://TestingArea.tscn")
	

func _on_menu_button_credits_pressed():
	pass # Replace with function body.


func _on_menu_button_quit_game_pressed():
	pass # Replace with function body.


func _on_h_slider_value_changed(value):
	emit_signal("volume_changed_signal", value)
