extends Node2D

@onready var dialogue_component = $GUI/DialogueComponent

func _ready():
	dialogue_component.hide()
	# This is fine for this game's small scale.
	$NPC.started_dialogue.connect(dialogue_component.start_dialogue)
