extends CharacterBody2D


var movement_speed = 35

func _physics_process(delta):
	player_movement(delta)
	
func player_movement(delta):
	var input_direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"),
	)
	
	velocity = input_direction * movement_speed
	
	move_and_slide()
