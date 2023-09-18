extends Control

@onready var inventory_button = $PanelContainer/VBoxContainer/Inventory
#@export var item_list: ListedItemList
@export var player: Player
@onready var v_box_container = $PanelContainer/VBoxContainer

const ITEM_LIST := preload("res://hud/item_list.tscn")

func set_focus() -> void:
	inventory_button.grab_focus()

func _on_inventory_pressed() -> void:
	#item_list.set_listed_item_list(player.item_list_data)
	hide()
	#item_list.show()
	#item_list.set_focus()
	var item_list = ITEM_LIST.instantiate()
	item_list.set_listed_item_list(player.item_list_data)
	print(get_parent())
	print(get_parent().get_parent())
	get_parent().get_parent().add_child(item_list)
	PlayerManager.player.state = PlayerManager.player.States.ITEM_LIST_OPENED

func _on_request_pressed():
	print("request pressed")

func _on_map_pressed():
	print("map pressed")

func _on_finish_pressed():
	print("finish pressed")
