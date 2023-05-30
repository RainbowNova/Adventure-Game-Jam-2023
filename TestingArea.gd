extends Node2D

@onready var dialogue_label = $GUI/DialogueComponent/VBoxContainer/HBoxContainer/MarginContainer2/DialogueLabel
@onready var name_label = $GUI/DialogueComponent/VBoxContainer/MarginContainer/NameLabel
@onready var portrait = $GUI/DialogueComponent/VBoxContainer/HBoxContainer/MarginContainer/Portrait

var dialogue_component

func _ready():
	$NPC.connect("started_dialogue", start_dialogue)
	dialogue_component = $GUI/DialogueComponent
	dialogue_component.hide()
	

func start_dialogue():
	dialogue_component.start_dialogue("npc1")
	
