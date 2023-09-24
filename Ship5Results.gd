extends Control

class_name Ship5Results

@onready var label_rating = $ColorRect/LabelRating
@onready var label_reward = $ColorRect/LabelReward
@onready var label_message = $ColorRect/LabelMessage
@onready var audio = $AudioStreamPlayer2D

const WIN_MUSIC = preload("res://sound/music/win.wav")
const LOSS_MUSIC = preload("res://sound/music/loss.wav")
const DAY_CHANGE = preload("res://scenes/day_change.tscn")

var points: int

func _ready():
	points = 0
	label_rating.text = calculate_rating()
	label_message.text = calculate_message()
	label_reward.text = calculate_reward()

func calculate_rating() -> String:
	var placeables: Array[PlaceableData] = PlayerManager.player.placed_placeables
	for p in placeables:
		points += p.elegant_value * 1.2
		points += p.rustic_value * 0.2
		points += p.futuristic_value * -0.4
		points += p.modern_value * -0.2
		points += p.otherworldly_value * -1
	points = snapped(points, 0.01)
	if points > 45:
		audio.stream = WIN_MUSIC
	else:
		audio.stream = LOSS_MUSIC
	audio.play()
	if points > 75:
		return "S"
	if points > 70:
		return "A+"
	if points > 65:
		return "A-"
	if points > 55:
		return "B+"
	if points > 45:
		return "B-"
	if points > 35:
		return "C+"
	if points > 25:
		return "C-"
	if points > 15:
		return "D"
	return "F"
	
func calculate_message() -> String:
	if points > 75:
		return "Perfect!"
	if points > 70:
		return "Awesome!"
	if points > 65:
		return "Awesome!"
	if points > 55:
		return "Good!"
	if points > 45:
		return "Good!"
	if points > 35:
		return "Good enough"
	if points > 25:
		return "Good enough"
	if points > 15:
		return "Could be better"
	return "Bad"
	
func calculate_reward() -> String:
	PlayerManager.player.earnings += snapped(points, 1) * 2
	return "Reward: " + str(snapped(points, 1) * 2)

func _input(event):
	if Input.is_action_just_pressed("gboy_a") or Input.is_action_just_pressed("gboy_select"):
		PlayerManager.player.current_day += 1
		await Transition.dissolve()
		var scene = DAY_CHANGE.instantiate()
		get_parent().add_child(scene)
		queue_free()
