extends Area2D

signal interacted
@onready var player = get_node("/root/Entities/Player/Player")

var can_interact : bool = false
	
func _ready():
	print(player)
	
# When the player tries to interact and is able to, do the interaction.
# TODO: Check if player is looking at the interactable using Raycase2D.
func _input(event):
	if event.is_action_pressed("interact") and can_interact:
		emit_signal("interacted")
		can_interact = false

# If the player gets within interaction range, allow them to interact.
func _on_body_entered(body):
	if body.name == "Player":
		can_interact = true

# If the player gets out of interaction range, no longer allow them to interact.
func _on_body_exited(body):
	if body.name == "Player":
		can_interact = false
