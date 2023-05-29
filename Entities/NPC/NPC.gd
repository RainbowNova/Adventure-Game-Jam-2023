extends CharacterBody2D

const DIALOGUE = preload("res://Assets/DialogueComponent/DialogueComponent.tscn")

var dialogue_started = false

# Signals sent by components should be handled by the parent-node.
# Potential TODO: create base class for NPC's.
# Potential TODO: let _ready() call specific function just for connecting signals.
func _ready():
	var interactable_component = get_node("InteractableComponent")
	interactable_component.connect("interacted", start_dialogue)
	var dialogue_component = get_node("DialogueComponent")
	dialogue_component.connect("dialogue_ended", end_dialogue)

func start_dialogue():	
	if dialogue_started == false:
		dialogue_started = true
		get_node("DialogueComponent").start_dialogue()

func end_dialogue():
	dialogue_started = false
