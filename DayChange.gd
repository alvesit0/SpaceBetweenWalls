extends Control

@onready var earnings_label: Label = $EarningsContainer/EarningsLabel
@onready var day_label: Label = $DayContainer/DayLabel

const FIRST_DAY_DIALOGE = preload("res://dialogues/elegant/ElegantDialogue.tscn")

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
		
	PlayerManager.player.state = PlayerManager.player.States.ITEM_PLACING
	queue_free()
