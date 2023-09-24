extends Control

const INTRO_SCENE = preload("res://scenes/intro_scene_1.tscn")

@export var start_button: Button
@export var credits_button: Button
var starting: bool

func _ready() -> void:
	await Transition.resolve()
	start_button.grab_focus()
	starting = false

func _on_start_game_pressed() -> void:
	if !starting:
		starting = true
		await Transition.dissolve()
		get_parent().add_child(INTRO_SCENE.instantiate())
		queue_free()
