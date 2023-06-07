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
