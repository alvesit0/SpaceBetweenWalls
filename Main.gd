extends Node

@onready var inventory_interface = $InventoryInterface
@onready var ingame_menu = $InventoryInterface/IngameMenu
@onready var player = $Player

func _ready() -> void:
	player.toggle_menu.connect(toggle_menu_interface)

func toggle_menu_interface() -> void:
	inventory_interface.visible = not inventory_interface.visible
	ingame_menu.set_focus()
