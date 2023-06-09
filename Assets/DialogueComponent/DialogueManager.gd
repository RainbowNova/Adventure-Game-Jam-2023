extends Control

signal interacted

var npc_name
var text_speed = 0.05

var first_sentence
var now_you_may_skip

var current_dialogue_path
var dialogue

var phrase_num = 0
var finished = false

@onready var dialogue_label = $VBoxContainer/HBoxContainer/MarginContainer2/DialogueLabel
@onready var name_label = $VBoxContainer/MarginContainer/NameLabel
@onready var portrait = $VBoxContainer/HBoxContainer/MarginContainer/Portrait

func start_dialogue(given_npc_name):
	# Based on npc_name, find dialogue_key.
	if !visible:
		first_sentence = true
		now_you_may_skip = false
		
		npc_name = given_npc_name
		show()
		phrase_num = 0
		# Create dialogue instance as child of the current area scene.	
		$Timer.wait_time = text_speed
		dialogue = get_dialogue()
		assert(dialogue, "Dialogue not found")
		next_phrase()
	

func _process(delta):
	# Skip dialogue or move to next.
	if Input.is_action_just_pressed("interact"):
		if finished:
			next_phrase()
		else:
			if now_you_may_skip:
				dialogue_label.visible_characters = len(dialogue_label.text)


func get_dialogue():
	current_dialogue_path = "res://DialogueFiles/dialogue_" + str(npc_name) + ".json"
	# System that filters json file to find out which conversation dialogue is needed.
	if FileAccess.file_exists(current_dialogue_path):
		var dataFile = FileAccess.open(current_dialogue_path, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		return parsedResult
	

func next_phrase():
	# If there's no more lines...
	if phrase_num >= len(dialogue):
		hide()
		return
	
	finished = false
	# Code for obtaining data from json file
	name_label.bbcode_text = dialogue[phrase_num]["Name"]
	dialogue_label.bbcode_text = dialogue[phrase_num]["Text"]
	
	# Typing / speaking animation
	dialogue_label.visible_characters = 0
	while dialogue_label.visible_characters < len(dialogue_label.text):
		# I could not find any other way to prevent the insta-skip.
		if dialogue_label.visible_characters > 1 and first_sentence and !now_you_may_skip:
			now_you_may_skip = true
			first_sentence = false
		dialogue_label.visible_characters += 1
		
		$Timer.start()
		await $Timer.timeout

	# Go to next line
	finished = true
	phrase_num += 1
	return
		
