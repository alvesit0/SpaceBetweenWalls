extends Button

signal slot_selected(index: int)

@export var texture_rect: TextureRect

var placeable_data: PlaceableData

func set_slot_data(slot_data: ListedItemData) -> void:
	placeable_data = slot_data.placeable_data
	texture_rect.texture = placeable_data.texture
	text = placeable_data.name
