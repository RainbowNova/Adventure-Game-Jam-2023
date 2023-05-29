extends CharacterBody2D

const DIALOGUE = preload("res://Assets/Dialogue/Dialogue.tscn")

var dialogue_started = false

# Signals sent by components should be handled by the parent-node.
# Potential TODO: create base class for NPC's.
# Potential TODO: let _ready() call specific function just for connecting signals.
func _ready():
	var interactable_component = get_node("InteractableComponent")
	interactable_component.connect("interacted", start_dialogue)


func start_dialogue():	
	dialogue_started = true
	var dialogue = DIALOGUE.instantiate()
	add_child(dialogue)
	dialogue.start_dialogue()
