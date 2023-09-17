extends Button

signal slot_selected(index: int)
@onready var item_name = $Name
@onready var texture_rect = $TextureRect
var placeable_data: PlaceableData

func set_slot_data(slot_data: ListedItemData) -> void:
	placeable_data = slot_data.placeable_data
	texture_rect.texture = placeable_data.texture
	item_name.text = placeable_data.name
