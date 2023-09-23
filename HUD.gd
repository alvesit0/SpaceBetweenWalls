extends CanvasLayer

class_name InGameHUD

@export var inventory_interface: Control
@export var ingame_menu: Control
var selector: Selector

func _ready():
	selector = get_parent().selector
	ingame_menu.selector = selector
