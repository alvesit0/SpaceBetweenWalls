extends PanelContainer

signal slot_selected(index: int)

@onready var item_name = $MarginContainer/Name
@onready var texture_rect = $MarginContainer/TextureRect

func set_slot_data(slot_data: ListedItemData) -> void:
	var placeable_data = slot_data.placeable_data
	texture_rect.texture = placeable_data.texture
	item_name = placeable_data.name
