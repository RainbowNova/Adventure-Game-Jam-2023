extends Node2D

signal conversation_key
@onready var dialogue_component = $GUI/DialogueComponent


func _ready():
	dialogue_component.hide()
	# This is fine for this game's small scale.
	$NPC.started_dialogue.connect(dialogue_component.start_dialogue)
	dialogue_component.connect("conversation_key", signal_up)
	
	
func signal_up(conversation_key):
	emit_signal("conversation_key", conversation_key)
