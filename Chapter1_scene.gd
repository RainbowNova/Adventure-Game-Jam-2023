extends CanvasLayer

var anim

# Called when the node enters the scene tree for the first time.
func _ready():
	anim = $AnimationPlayer
	anim.play("fade_in")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_in":
		anim.play("fade_out")
	elif anim_name == "fade_out":
		queue_free()
