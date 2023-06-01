extends CharacterBody2D

signal started_dialogue

@export var npc_name = "npc1"


func _ready():
	$InteractableComponent.connect("interacted", send_dialogue_signal)


func send_dialogue_signal():
	started_dialogue.emit(npc_name)
