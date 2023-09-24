extends Control

@onready var earnings_label: Label = $EarningsContainer/EarningsLabel
@onready var day_label: Label = $DayContainer/DayLabel

const FIRST_DAY_DIALOGE = preload("res://dialogues/elegant/ElegantDialogue.tscn")
const SECOND_DAY_DIALOGE = preload("res://dialogues/elegant/ModernDialogue.tscn")
const THIRD_DAY_DIALOGE = preload("res://dialogues/elegant/FuturisticDialogue.tscn")
const FOURTH_DAY_DIALOGE = preload("res://dialogues/elegant/RusticDialogue.tscn")
const FIFTH_DAY_DIALOGE = preload("res://dialogues/elegant/OtherworldlyDialogue.tscn")

func _ready():
	day_label.text = "Day " + str(PlayerManager.player.current_day)
	earnings_label.text = "Earnings:" + str(PlayerManager.player.earnings)
	Transition.resolve_no_await()
	$AnimationPlayer.play("day_down")

func _on_timer_timeout():
	await Transition.dissolve()
	var scene
	match PlayerManager.player.current_day:
		1: 
			scene = FIRST_DAY_DIALOGE.instantiate()
			get_parent().add_child(scene)
		2: 
			scene = SECOND_DAY_DIALOGE.instantiate()
			get_parent().add_child(scene)
		3: 
			scene = THIRD_DAY_DIALOGE.instantiate()
			get_parent().add_child(scene)
		4: 
			scene = FOURTH_DAY_DIALOGE.instantiate()
			get_parent().add_child(scene)
		5: 
			scene = FIFTH_DAY_DIALOGE.instantiate()
			get_parent().add_child(scene)
		
	PlayerManager.player.state = PlayerManager.player.States.ITEM_PLACING
	queue_free()
