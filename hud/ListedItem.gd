extends Button

class_name ListedItem

signal slot_selected(index: int)

@export var texture_rect: TextureRect
@export var price_label: Label

var placeable_data: PlaceableData

func set_slot_data(slot_data: ListedItemData) -> void:
	placeable_data = slot_data.placeable_data
	texture_rect.texture = placeable_data.texture
	text = placeable_data.name
	price_label.text = convert_from_int(placeable_data.price)

func convert_from_int(val: int) -> String:
	if val < 10:
		return "000" + str(val) + "$"
	elif val < 100:
		return "00" + str(val) + "$"
	elif val < 1000:
		return "0" + str(val) + "$"
	else:
		return str(val) + "$"
