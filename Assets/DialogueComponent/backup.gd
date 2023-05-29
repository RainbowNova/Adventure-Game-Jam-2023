extends Control

signal interacted

var dialogue_path = "res://DialogueFiles/test_dialogue.json"
var text_speed = 0.05

var dialogue

var phrase_num = 0
var finished = false


func start_dialogue():
	# Create dialogue instance as child of the current area scene.	
	$Timer.wait_time = text_speed
	dialogue = get_dialogue()
	assert(dialogue, "Dialogue not found")
	next_phrase()
	

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		print("Hmmmm")
		if finished:
			next_phrase()
		else:
			$VBoxContainer/ColorRect/DialogueLabel.visible_characters = len($VBoxContainer/ColorRect/DialogueLabel.text)


func get_dialogue():
	var f = FileAccess.open(dialogue_path, FileAccess.READ)
	
	f.open(dialogue_path, FileAccess.READ)
	var json = f.get_as_text()
	
	var output = JSON.parse_string(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []


func next_phrase():
	if phrase_num >= len(dialogue):
		return
	finished = false
	$VBoxContainer/ColorRect/NameLabel.bbcode_text = dialogue[phrase_num]["Name"]
	$VBoxContainer/ColorRect/DialogueLabel.bbcode_text = dialogue[phrase_num]["Text"]
	
	$VBoxContainer/ColorRect/DialogueLabel.visible_characters = 0
	
	while $VBoxContainer/ColorRect/DialogueLabel.visible_characters < len($VBoxContainer/ColorRect/DialogueLabel.text):
		$VBoxContainer/ColorRect/DialogueLabel.visible_characters += 1
		
		$Timer.start()
		await $Timer.timeout
		
	finished = true
	phrase_num += 1
	return
		
