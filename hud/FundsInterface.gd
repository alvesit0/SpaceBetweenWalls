extends Control

@onready var label = $PanelContainer/Label

func _process(_delta):
	var value: int = PlayerManager.player.funds
	if value < 10:
		label.text = "000" + str(value) + "$"
	elif value < 100:
		label.text = "00" + str(value) + "$"
	elif value < 1000:
		label.text = "0" + str(value) + "$"
	elif value < 10000:
		label.text = str(value) + "$"
