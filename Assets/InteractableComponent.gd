extends Area2D

var can_interact : bool = false

func _ready():
	pass
	

func _process(delta):
	pass
	
# When the player tries to interact and is able to, do the interaction.
# TODO: Check if player is looking at the interactable.
func _input(event):
	if event.is_action_pressed("interact") and can_interact:
		for body in get_overlapping_bodies():
			print(body.name)
			interact()

# If the player gets within interaction range, allow them to interact.
func _on_body_entered(body):
	if body.name == "Player":
		can_interact = true

# If the player gets out of interaction range, no longer allow them to interact.
func _on_body_exited(body):
	if body.name == "Player":
		can_interact = false
		

func interact():
	pass
