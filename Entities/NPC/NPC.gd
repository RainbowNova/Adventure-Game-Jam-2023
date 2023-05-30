extends CharacterBody2D

signal started_dialogue

const DIALOGUE = preload("res://Assets/DialogueComponent/DialogueComponent.tscn")

@export var npc_name = "npc1"
@export var text_speed = 0.05
@export var portrait_texture : Sprite2D # Add texture here


func _ready():
	$InteractableComponent.connect("interacted", send_dialogue_signal)


func send_dialogue_signal():
	started_dialogue.emit(npc_name)
