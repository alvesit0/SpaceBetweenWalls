extends Control

class_name FinishConfirm

@onready var yes_button = $PanelContainer/VBoxContainer/HBoxContainer/YesButton
@onready var no_button = $PanelContainer/VBoxContainer/HBoxContainer/NoButton
@onready var back_sound = $BackSound
@onready var move_sound = $MoveSound

signal finish_canceled

func _ready() -> void:
	set_focus()

func set_focus() -> void:
	no_button.grab_focus()
	
func _input(event):
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		move_sound.play()

func _on_yes_button_pressed():
	back_sound.play()
	await Transition.dissolve()
	PlayerManager.player.transition_stage()
	for child in get_parent().get_parent().get_children():
		if child is Ship:
			child.queue_free()
	get_parent().queue_free()

func _on_no_button_pressed():
	back_sound.play()
	PlayerManager.player.state = PlayerManager.player.States.ITEM_PLACING
	finish_canceled.emit()
	queue_free()
