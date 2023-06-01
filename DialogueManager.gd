extends Node

var dialogue_manager_json_path
var dialogue_file_json_path

var dialogue_manager_json
var dialogue_file_json


func _ready():
	dialogue_manager_json_path = "res://Dialogue/DialogueManager.json"
	dialogue_file_json_path = "res://Dialogue/DialogueFile.json"
	
	dialogue_manager_json = get_parsed_json_file(dialogue_manager_json_path)
	dialogue_file_json = get_parsed_json_file(dialogue_file_json_path)
	
	start_dialogue("npc1")


func get_parsed_json_file(json_path):	
	# System that filters json file to find out which conversation dialogue is needed.
	if FileAccess.file_exists(json_path):
		var data_file = FileAccess.open(json_path, FileAccess.READ)
		var parsed_result = JSON.parse_string(data_file.get_as_text())
		return parsed_result


func start_dialogue(given_npc_name):
	# If currently showing dialogue, stop dialogue process.
	# if visible:
	# return
	# else:

	# Otherwise, start dialogue process: Use NPC name to get NPC conversation key
	var current_conversation_key = get_conversation_key(given_npc_name)
	# If the current_conversation_key is null, dialogue can end here.
	
	# Else, if the CCK is not null, continue by getting the conversation data.
	# E.g. name, dialogue, portrait, text_speed.
	var dialogue_data = get_dialogue_data(given_npc_name, current_conversation_key)
	go_through_dialogue_data(dialogue_data)
	
func get_conversation_key(npc_name):
	print(dialogue_manager_json)
	for i in dialogue_manager_json:
		print(i)
		print(i[0])
	# In DialogueFileManager.json, look for npc_name and find the current conversation_key
	if dialogue_manager_json[npc_name] == null:
		print("Something went wrong. NPC does not seem to have any dialogue.")
	# If current conversation key is null, no more conversations.
	elif dialogue_manager_json[npc_name]["current_conversation_key"] == null:
		print("No more conversations exist for this NPC.")
	# If current conversation key is not null, return conversation key.
	else:
		return (dialogue_manager_json[npc_name]["current_conversation_key"])


func get_dialogue_data(npc_name, conversation_key):
	pass	
	# In DialogueFile.json, find the conversation key within the npc's 'dialogue tree'.
	
	# Return entire dialogue from the conversation. Do not filter yet. Separation of concerns.


# After getting the entire dialogue, go through it line by line.
func go_through_dialogue_data(conversation_object):
	pass
	# conversation_object contains all lines within a conversation.
	# Meaning every line type (regular, choice), name of speaker, emotion (for portrait + voice sound), type_speed and the dialogue text itself.
	# EVENTUALLY make it so type_speed and maybe even emotion can be built into the json. For now just 1 for entire sentences.
	
	# Every line
	# Set name to name_label
	# Make it so emotion causes the correct portrait to appear + correct voice_sound to be played.
	
