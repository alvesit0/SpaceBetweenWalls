extends Control

const INTRO_SCENE = preload("res://scenes/intro_scene_1.tscn")

@export var start_button: Button
@export var credits_button: Button
@export var credit_roll_list: Array[Control]
@export var credits_roll: Control
var credit_index: int
var starting: bool
var on_credits: bool

func _ready() -> void:
	await Transition.resolve()
	start_button.grab_focus()
	starting = false
	on_credits = false
	credit_index = 0
	
func _input(event):
	if on_credits and (Input.is_action_just_pressed("gboy_b") or Input.is_action_just_pressed("gboy_a")):
		$AnimationPlayer.play_backwards("move_everything")
		await $AnimationPlayer.animation_finished
		on_credits = false

func _on_start_game_pressed() -> void:
	if !starting and !on_credits:
		starting = true
		await Transition.dissolve()
		get_parent().add_child(INTRO_SCENE.instantiate())
		queue_free()

func _on_credits_pressed():
	print("yepa")
	if !on_credits:
		print("awatafa")
		on_credits = true
		$AnimationPlayer.play("move_everything")

func _on_timer_timeout():
	$CreditsAnimPlayer.play("dissolve_credits")
	await $CreditsAnimPlayer.animation_finished
	for child in credits_roll.get_children():
		child.visible = false
	if credit_index < credit_roll_list.size() - 1:
		credit_index += 1
	else:
		credit_index = 0
	credit_roll_list[credit_index].visible = true
	$CreditsAnimPlayer.play_backwards("dissolve_credits")
	await $CreditsAnimPlayer.animation_finished
