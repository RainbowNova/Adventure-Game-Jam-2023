extends CharacterBody2D


var movement_speed = 50

func _physics_process(delta):
	player_movement(delta)
	
func player_movement(delta):
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * movement_speed
	move_and_slide()
