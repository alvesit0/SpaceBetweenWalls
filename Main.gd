extends Node

class_name Main

@export var hud: InGameHUD
@export var player: Player

func _ready() -> void:
	player.toggle_menu.connect(toggle_menu_interface)
	PlayerManager.player = player

func toggle_menu_interface() -> void:
	if PlayerManager.player.state == PlayerManager.player.States.ITEM_PLACING \
	or PlayerManager.player.state == PlayerManager.player.States.MENU_OPENED \
	or PlayerManager.player.state == PlayerManager.player.States.ITEM_LIST_OPENED:
		hud.inventory_interface.visible = not hud.inventory_interface.visible
		hud.ingame_menu.visible = hud.inventory_interface.visible
		if PlayerManager.player.state != PlayerManager.player.States.ITEM_PLACING:
			PlayerManager.player.state = PlayerManager.player.States.ITEM_PLACING
		else:
			PlayerManager.player.state = PlayerManager.player.States.MENU_OPENED
		for child in hud.get_children():
			if child is ListedItemList:
				child.queue_free()
		hud.ingame_menu.set_focus()
