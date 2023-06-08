extends Node2D

signal test_button

@onready var dialogue_component = $GUI/DialogueComponent

func _ready():
	dialogue_component.hide()
	# This is fine for this game's small scale.
	$NPC.started_dialogue.connect(dialogue_component.start_dialogue)


func _on_button_pressed():
	emit_signal("test_button")
