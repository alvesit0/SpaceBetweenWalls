extends Node2D

const Balloon = preload("res://dialogues/elegant/elegantBalloon.tscn")

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "talk_to_elegant"

func _ready():
	var balloon: Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialogue_start)
