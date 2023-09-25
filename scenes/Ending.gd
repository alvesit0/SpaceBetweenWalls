extends Control

const WIN_MUSIC = preload("res://sound/music/win.wav")
const LOSS_MUSIC = preload("res://sound/music/loss.wav")

const GOOD_ENDING = preload("res://images/goodEnding.png")
const BAD_ENDING = preload("res://images/badEnding.png")

const MAIN_MENU = preload("res://scenes/main_menu.tscn")

@onready var audio = $AudioStreamPlayer2D
@onready var texture_rect = $TextureRect

func _ready():
	await Transition.resolve()
	if PlayerManager.player.earnings > 500:
		texture_rect.texture = GOOD_ENDING
		audio.stream = WIN_MUSIC
	else:
		texture_rect.texture = BAD_ENDING
		audio.stream = LOSS_MUSIC

func _input(event):
	if Input.is_action_just_pressed("gboy_a") \
	or Input.is_action_just_pressed("gboy_b") \
	or Input.is_action_just_pressed("gboy_start"):
		PlayerManager.player.earnings = 0
		PlayerManager.player.placed_placeables.clear()
		var menu = MAIN_MENU.instantiate()
		get_parent().add_child(menu)
		queue_free()
