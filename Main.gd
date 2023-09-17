extends Node

@onready var inventory_interface = $InventoryInterface
@onready var ingame_menu = $InventoryInterface/IngameMenu
@onready var item_list = $InventoryInterface/ItemList
@onready var player = $Player

func _ready() -> void:
	player.toggle_menu.connect(toggle_menu_interface)
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func toggle_menu_interface() -> void:
	inventory_interface.visible = not inventory_interface.visible
	ingame_menu.visible = inventory_interface.visible
	item_list.visible = false
	if PlayerManager.player.state != PlayerManager.player.States.ITEM_PLACING:
		PlayerManager.player.state = PlayerManager.player.States.ITEM_PLACING
	else:
		PlayerManager.player.state = PlayerManager.player.States.MENU_OPENED
	ingame_menu.set_focus()
