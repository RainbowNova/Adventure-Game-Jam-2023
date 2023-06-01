extends CharacterBody2D

signal started_dialogue

@export var npc_name = "npc1"
@export var my_emotions : Resource
# Variables type_speed and portrait have been removed.
# They are DialogueManager's to handle, not NPC's.

func _ready():
	$InteractableComponent.connect("interacted", send_dialogue_signal)

func send_dialogue_signal():
	# Add potential conditions for starting dialogue here?
	# Might be better to put conditions into DialogueManager?
	started_dialogue.emit(npc_name)
