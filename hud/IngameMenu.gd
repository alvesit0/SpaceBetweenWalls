extends Control

@onready var inventory_button = $PanelContainer/VBoxContainer/Inventory
@onready var item_list = $"../ItemList"
@onready var player = $"../../Player"

const ITEM_LIST = preload("res://hud/item_list.tscn")

func set_focus() -> void:
	inventory_button.grab_focus()

func _on_inventory_pressed() -> void:
	inventory_button.release_focus()
	item_list.set_listed_item_list(player.item_list_data)
	item_list.show()

func _on_request_pressed():
	print("request pressed")

func _on_map_pressed():
	print("map pressed")

func _on_finish_pressed():
	print("finish pressed")
