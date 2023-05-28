extends Area2D

signal interacted

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent):
	if event.is_action_pressed("interact"):
		emit_signal("interacted")
