extends Control

class_name FinishConfirm

@onready var yes_button = $PanelContainer/VBoxContainer/HBoxContainer/YesButton
@onready var no_button = $PanelContainer/VBoxContainer/HBoxContainer/NoButton

signal finish_canceled

func _ready() -> void:
	set_focus()

func set_focus() -> void:
	no_button.grab_focus()

func _on_yes_button_pressed():
	print("yes pressed!!!")

func _on_no_button_pressed():
	PlayerManager.player.state = PlayerManager.player.States.ITEM_PLACING
	queue_free()
	finish_canceled.emit()
