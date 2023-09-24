extends Control

class_name IntroScene1

@onready var first_scene = $FirstScene
@onready var second_scene = $SecondScene
@onready var third_scene = $ThirdScene
@onready var animation_player = $AnimationPlayer

const SECOND_SCENE = preload("res://scenes/intro_scene_2.tscn")
var can_continue: bool
var continue_pressed: bool

func _ready():
	can_continue = false
	continue_pressed = false
	Transition.reset()
	
func _input(event):
	if can_continue and !continue_pressed \
	and (Input.is_action_just_pressed("gboy_a")
	or Input.is_action_just_pressed("gboy_b")
	or Input.is_action_just_pressed("gboy_start")):
		continue_pressed = true
		await Transition.dissolve()
		get_parent().add_child(SECOND_SCENE.instantiate())
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
