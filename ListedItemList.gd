extends PanelContainer

class_name ListedItemList

const ListedItem = preload("res://listed_item.tscn")

@onready var all_item_list = $TabContainer/All/AllItemList

func set_listed_item_list(listed_item_list_data: ListedItemListData) -> void:
	listed_item_list_data.inventory_updated.connect(populate_item_grid)
	populate_item_grid(listed_item_list_data)
	
func clear_listed_item_list(listed_item_list_data: ListedItemListData) -> void:
	listed_item_list_data.inventory_updated.disconnect(populate_item_grid)

func populate_item_grid(listed_item_list_data: ListedItemListData) -> void:
	for child in all_item_list.get_children():
		child.queue_free()
		
	for item_data in listed_item_list_data.listed_items:
		var slot = ListedItem.instantiate()
		all_item_list.add_child(slot)
		
		slot.slot_selected.connect(listed_item_list_data.on_item_selected)
