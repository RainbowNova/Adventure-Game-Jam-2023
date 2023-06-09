extends CharacterBody2D

@export var movement_speed: int
@onready var animations = $AnimationPlayer

var interaction_list = []
	
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


func _input(event):
	if event.is_action_pressed("interact"):
		emit_signal("interacting", interaction_list[0])


func _on_interaction_zone_area_entered(area):
	if area not in interaction_list:
		interaction_list.append(area)
		$Label.visible = true


func _on_interaction_zone_area_exited(area):
	if area in interaction_list:
		interaction_list.erase(area)
		if interaction_list.is_empty():
			$Label.visible = false
