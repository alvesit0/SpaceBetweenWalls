extends Control

const INTRO_SCENE = preload("res://intro_scene_1.tscn")

@export var start_button: Button
@export var credits_button: Button

func _ready() -> void:
	await Transition.resolve()
	start_button.grab_focus()

func _on_start_game_pressed() -> void:
	await Transition.dissolve()
	get_parent().add_child(INTRO_SCENE.instantiate())
	queue_free()
