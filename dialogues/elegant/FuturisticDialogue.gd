extends Node2D

const Balloon = preload("res://dialogues/elegant/elegantBalloon.tscn")

const SHIP_SCENE = preload("res://scenes/ship_3.tscn")
const INGAME_HUD_SCENE = preload("res://scenes/ingame_hud.tscn")

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "talk_to_nerd"
@export var animated_sprite: AnimatedSprite2D
@export var talking_sounds: AudioStreamPlayer2D

var talking: bool

func _ready():
	await Transition.resolve()
	var balloon: Baloon = Balloon.instantiate()
	add_child(balloon)
	PlayerManager.dialogue_finished.connect(_on_dilogue_finished)
	balloon.on_dialogue_finished.connect(_on_line_finished)
	balloon.on_paused_typing.connect(_on_paused_typing)
	balloon.on_spoke.connect(_on_spoke)
	balloon.start(dialogue_resource, dialogue_start)

func _on_dilogue_finished() -> void:
	await Transition.dissolve()
	var hud = INGAME_HUD_SCENE.instantiate()
	get_parent().add_child(SHIP_SCENE.instantiate())
	get_parent().add_child(hud)
	var main_scene: Main = get_parent() 
	main_scene.hud = hud
	queue_free()
	
func _on_line_finished():
	animated_sprite.stop()
	talking = false
	
func _on_paused_typing():
	print("paused typing")

func _on_spoke():
	if !talking:
		animated_sprite.play("default")
		talking = true
	talking_sounds.play()
