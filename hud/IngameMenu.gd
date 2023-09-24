extends Control

@onready var inventory_button = $PanelContainer/VBoxContainer/Inventory
@onready var v_box_container = $PanelContainer/VBoxContainer
@onready var back_sound = $BackSound
@onready var move_sound = $MoveSound

var selector: Selector

const ITEM_LIST := preload("res://hud/listed_item_list.tscn")
const FINISH_CONFIRM := preload("res://hud/finish_confirm.tscn")

func set_focus() -> void:
	inventory_button.grab_focus()
	selector = get_parent().get_parent().selector
	
func _process(_delta):
	if Input.is_action_just_pressed("gboy_b") \
	and PlayerManager.player.state == PlayerManager.player.States.MENU_OPENED:
		back_sound.play()
		hide()
		PlayerManager.player.state = PlayerManager.player.States.ITEM_PLACING
	if (Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down")) \
	and PlayerManager.player.state == PlayerManager.player.States.MENU_OPENED:
		move_sound.play()

func _on_inventory_pressed() -> void:
	back_sound.play()
	hide()
	var item_list = ITEM_LIST.instantiate()
	item_list.set_listed_item_list(PlayerManager.player.item_list_data)
	get_parent().get_parent().add_child(item_list)
	PlayerManager.player.state = PlayerManager.player.States.ITEM_LIST_OPENED

func _on_map_pressed():
	back_sound.play()
	hide()
	selector.toggle_camera()
	PlayerManager.player.state = PlayerManager.player.States.ZOOMED_OUT

func _on_finish_pressed():
	back_sound.play()
	hide()
	selector.toggle_camera()
	var finish_confirm = FINISH_CONFIRM.instantiate()
	get_parent().get_parent().add_child(finish_confirm)
	finish_confirm.finish_canceled.connect(_on_finish_canceled)
	PlayerManager.player.state = PlayerManager.player.States.ON_CONFIRM_WINDOW
	
func _on_finish_canceled():
	selector.toggle_camera()
