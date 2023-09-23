extends Node2D

const Balloon = preload("res://dialogues/elegant/elegantBalloon.tscn")

const SHIP_SCENE = preload("res://scenes/ship_1.tscn")
const INGAME_HUD_SCENE = preload("res://scenes/ingame_hud.tscn")

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "talk_to_elegant"

func _ready():
	await Transition.resolve()
	var balloon: Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	PlayerManager.dialogue_finished.connect(_on_dilogue_finished)
	balloon.start(dialogue_resource, dialogue_start)

func _on_dilogue_finished() -> void:
	await Transition.dissolve()
	var hud = INGAME_HUD_SCENE.instantiate()
	get_parent().add_child(SHIP_SCENE.instantiate())
	get_parent().add_child(hud)
	var main_scene: Main = get_parent() 
	main_scene.hud = hud
	queue_free()
