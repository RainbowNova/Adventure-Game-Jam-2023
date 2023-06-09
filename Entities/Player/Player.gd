extends CharacterBody2D

@export var movement_speed: int
@onready var animations = $AnimationPlayer

	
func player_movement(delta):
	var move_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = move_direction * movement_speed


func update_animation():
	if velocity.length() == 0:
		animations.stop()
	else:
		var direction = "down"
		if velocity.x < 0: direction = "left"
		elif velocity.x > 0: direction = "right"
		elif velocity.y < 0: direction = "up"

		animations.play("walk_" + direction)


func _physics_process(delta):
	player_movement(delta)
	move_and_slide()
	update_animation()


func _on_interaction_zone_area_entered(area):
	$Label.visible = true


func _on_interaction_zone_area_exited(area):
	$Label.visible = false
