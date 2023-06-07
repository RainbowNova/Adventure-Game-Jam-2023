extends Control

var dialogue_manager_json_path
var dialogue_file_json_path

var dialogue_manager_json
var dialogue_file_json
var current_conversation_json # Feel like this isn't best OOP practice, but works for now.

var next_conversation_key
var current_line


@onready var dialogue_label = $VBoxContainer/HBoxContainer/MarginContainer2/DialogueLabel
@onready var name_label = $VBoxContainer/MarginContainer/NameLabel
@onready var portrait = $VBoxContainer/HBoxContainer/MarginContainer/Portrait
var portrait_string # Should use custom resources or something, but not implemented in Godot 4 in the way I need yet.

var finished
var now_you_may_skip
var phrase_num

var Name
var Emotion
var Text


func _ready():
	dialogue_manager_json_path = "res://Dialogue/DialogueManager.json"
	dialogue_file_json_path = "res://Dialogue/DialogueFile.json"
	
	dialogue_manager_json = get_parsed_json_file(dialogue_manager_json_path)
	dialogue_file_json = get_parsed_json_file(dialogue_file_json_path)


func _process(delta):
	skip_dialogue()


func get_parsed_json_file(json_path):	
	# System that filters json file to find out which conversation dialogue is needed.
	if FileAccess.file_exists(json_path):
		var data_file = FileAccess.open(json_path, FileAccess.READ) # Never closing ==> Bad
		var parsed_result = JSON.parse_string(data_file.get_as_text())
		return parsed_result


func start_dialogue(given_npc_name):
	# If currently already showing dialogue, stop dialogue process.
	# Might be better to stop at the sending of the signal; potential technical debt for later.
	if visible:
		return

	# Otherwise, start dialogue process: Use NPC name to get NPC conversation key
	var current_conversation_key = get_conversation_key(given_npc_name)
	
	# If the current_conversation_key is null, dialogue can end here.
	if current_conversation_key == null:
		end_dialogue()
		return
	
	phrase_num = 0
	
	# Else, if the CCK is not null, continue by getting the conversation data.
	# E.g. name, dialogue, portrait, text_speed.
	current_conversation_json = get_dialogue_data(given_npc_name, current_conversation_key)
	show()
	# Gets only called once per signal.
	scan_dialogue_data(current_conversation_json)
	
	
func get_conversation_key(npc_name):
	# In DialogueFileManager.json, look for npc_name and find the current conversation_key
	if dialogue_manager_json[npc_name] == null:
		print("Something went wrong. NPC does not seem to have any dialogue.")
	# If current conversation key is null, no more conversations.
	elif dialogue_manager_json[npc_name]["current_conversation_key"] == null:
		print("No more conversations exist for this NPC.")
	# If current conversation key is not null, return conversation key.
	return (dialogue_manager_json[npc_name]["current_conversation_key"])


func set_conversation_key(npc_name, conversation_key):
	# This entire part of the system should be refactored sometime.
	# For now it works. But this does not actually write to the json file! Just to the currently
	# saved variable containing the dialogue from the json file!
	dialogue_manager_json[npc_name]["current_conversation_key"] = conversation_key


func get_dialogue_data(npc_name, conversation_key):
	var current_conversation_json = dialogue_file_json[npc_name][conversation_key]
	return current_conversation_json


# Right now this function goes through the dialogue and 'reads' it ==> puts it into dialogue box.
# Ideally this should only read and put everything into place for another function to actually decide what to do.
# So what is the name, what is the dialogue, but also are there choices or conditions?
func scan_dialogue_data(conversation_object):
	# Check if there are any lines of dialogue left.	
	if phrase_num >= len(conversation_object) - 1:
		next_conversation_key = conversation_object[phrase_num]
		set_conversation_key(Name, next_conversation_key)
		hide()
		return
	finished = false
	# After every line, this function will be called.
	# Line left ==> set variables for dialogue box.
	
	current_line = conversation_object[phrase_num]
	# Might be useful for future functions like scanning_dialogue_lines for special characters and stuff?
	Name = current_line["Name"]
	Emotion = current_line["Emotion"]
	Text = current_line["Text"]
	
	name_label.bbcode_text = Name
	set_emotion_variables(Name, Emotion)
	dialogue_label.bbcode_text = Text
	
	if conversation_object[phrase_num]["Emotion"] == "Neutral":
		var type_speed = 0.05
		$Timer.wait_time = type_speed
	
	
	# Once the variables have been set, start playing the text (and animations and sounds).
	dialogue_label.visible_characters = 0
	while dialogue_label.visible_characters < len(dialogue_label.text):
		if dialogue_label.visible_characters > 1 and !now_you_may_skip:
			now_you_may_skip = true
		dialogue_label.visible_characters += 1
		
		$Timer.start()
		await $Timer.timeout

	# Tells the Dialogue overlords that this line is finished.
	phrase_num += 1
	finished = true
	return


# This entire function is ginormously scuffed, but it works.
# Would prefer for portraits to be automatically changed based purely on the Emotion data by using Custom Resources.
func set_emotion_variables(Name, Emotion):
	var portrait_string = "res://Assets/Textures/" + Name + "_" + Emotion + ".png"
	portrait.texture = load(portrait_string)
	
	# Set typing speed?
	
	# Eventually also add noise to play here.
	
	# Also add animation to play here? 


func skip_dialogue():
		# Skip dialogue or move to next.
	if Input.is_action_just_pressed("interact"):
		if finished:
			scan_dialogue_data(current_conversation_json)
		else:
			if now_you_may_skip:
				dialogue_label.visible_characters = len(dialogue_label.text)


func end_dialogue():
	hide() # TODO: EVENTUALLY (post-game-jam) turn this into queue_free()
