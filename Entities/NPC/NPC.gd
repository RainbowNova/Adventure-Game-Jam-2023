extends CharacterBody2D

const DIALOGUE = preload("res://Assets/DialogueComponent/DialogueComponent.tscn")

@export var npc_name = "npc1"
@export var text_speed = 0.05
@export var portrait_texture : Sprite2D # Add texture here

var dialogue_started = false
var current_dialogue_key = "intro-convo"

# Signals sent by components should be handled by the parent-node.
# Potential TODO: create base class for NPC's.
# Potential TODO: let _ready() call specific function just for connecting signals.
func _ready():
	var interactable_component = get_node("InteractableComponent")
	interactable_component.connect("interacted", start_dialogue)

func start_dialogue():	
	# Might be better to move this logic to DialogueComponent
	# But then would have to hide/show dialogue components.
	# Might be bad practice to hide/show when needed instead of destroying/creating when needed.
	# Best to leave this for now.
	if dialogue_started == false:
		var dialogue = DIALOGUE.instantiate()
		add_child(dialogue)
		dialogue.connect("dialogue_ended", end_dialogue)
		
		dialogue_started = true
		
		dialogue.start_dialogue(npc_name)

func end_dialogue():
	dialogue_started = false
