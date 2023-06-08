extends MarginContainer

signal start_game

var _main_menu_bus
var _temp_game_bus

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_menu_button_start_game_pressed():
	emit_signal("start_game")
	

func _on_menu_button_credits_pressed():
	pass # Replace with function body.


func _on_menu_button_quit_game_pressed():
	pass # Replace with function body.


func _on_h_slider_value_changed(value):
	pass
	# Couldn't get this to work, figured out why, no time to fix it now however.
	# Solution: signal up to World.gd and set volume for all scenes there.
