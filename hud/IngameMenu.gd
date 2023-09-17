extends Control

@onready var inventory_button = $PanelContainer/VBoxContainer/Inventory
@onready var item_list = $"../ItemList"
@onready var player = $"../../Player"
@onready var v_box_container = $PanelContainer/VBoxContainer

func set_focus() -> void:
	inventory_button.grab_focus()

func _on_inventory_pressed() -> void:
	v_box_container.release_focus()
	item_list.set_listed_item_list(player.item_list_data)
	item_list.show()
	item_list.set_focus()
	hide()
	PlayerManager.player.state = PlayerManager.player.States.ITEM_LIST_OPENED

func _on_request_pressed():
	print("request pressed")

func _on_map_pressed():
	print("map pressed")

func _on_finish_pressed():
	print("finish pressed")
