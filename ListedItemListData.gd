extends Resource

class_name ListedItemListData

signal inventory_updated(inventory_data: ListedItemListData)
signal inventory_interact(item_list_data: ListedItemListData, index: int)

@export var listed_items: Array[ListedItemData]

func on_item_selected(index: int) -> void:
	inventory_interact.emit(self, index)
