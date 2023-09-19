extends Node

@export var inventory_interface: Control
@export var ingame_menu: Control
@export var canvas_layer: CanvasLayer
@export var player: Player

func _ready() -> void:
	player.toggle_menu.connect(toggle_menu_interface)

func toggle_menu_interface() -> void:
	inventory_interface.visible = not inventory_interface.visible
	ingame_menu.visible = inventory_interface.visible
	if PlayerManager.player.state != PlayerManager.player.States.ITEM_PLACING:
		PlayerManager.player.state = PlayerManager.player.States.ITEM_PLACING
	else:
		PlayerManager.player.state = PlayerManager.player.States.MENU_OPENED
	for child in canvas_layer.get_children():
		if child is ListedItemList:
			child.queue_free()
	ingame_menu.set_focus()
