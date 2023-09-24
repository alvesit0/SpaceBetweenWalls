extends Control

class_name IntroScene2

@onready var first_scene = $FirstScene
@onready var second_scene = $SecondScene
@onready var third_scene = $ThirdScene
@onready var animation_player = $AnimationPlayer
@onready var menu_accept_sounds = $MenuAcceptSounds

const DAY_CHANGE_SCENE = preload("res://scenes/day_change.tscn")
var can_continue: bool
var continue_pressed: bool

func _ready():
	can_continue = false
	Transition.reset()
	
func _input(event):
	if can_continue and !continue_pressed \
	and (Input.is_action_just_pressed("gboy_a")
	or Input.is_action_just_pressed("gboy_b")
	or Input.is_action_just_pressed("gboy_start")):
		menu_accept_sounds.play()
		continue_pressed = true
		await Transition.dissolve()
		for child in get_parent().get_children():
			if child is AudioStreamPlayer2D:
				child.queue_free()
		get_parent().add_child(DAY_CHANGE_SCENE.instantiate())
		queue_free()

func _on_timer_first_scene_timeout():
	animation_player.play("first_scene_fade_in")
	await animation_player.animation_finished
	first_scene.play()

func _on_timer_second_scene_timeout():
	animation_player.play("second_scene_fade_in")
	await animation_player.animation_finished
	second_scene.play()

func _on_timer_third_scene_timeout():
	animation_player.play("third_scene_fade_in")
	await animation_player.animation_finished
	third_scene.play()

func _on_third_scene_animation_finished():
	can_continue = true
	$Arrow.visible = true
