extends PanelContainer

class_name ListedItemList

const LISTED_ITEM = preload("res://hud/listed_item.tscn")
const ALL_ICON = preload("res://question_mark.png")

@onready var all_tab = $TabContainer/All
@onready var all_items_container = $TabContainer/All/AllItemsContainer
@onready var tab_container = $TabContainer

func _ready() -> void:
	tab_container.set_tab_icon(0, ALL_ICON)
	tab_container.set_tab_title(0, "")
	tab_container.set_tab_title(1, "R")
	tab_container.set_tab_title(2, "E")
	tab_container.set_tab_title(3, "F")
	tab_container.set_tab_title(4, "M")
	tab_container.set_tab_title(5, "O")

func set_listed_item_list(listed_item_list_data: ListedItemListData) -> void:
	listed_item_list_data.inventory_updated.connect(populate_item_grid)
	populate_item_grid(listed_item_list_data)
	
func clear_listed_item_list(listed_item_list_data: ListedItemListData) -> void:
	listed_item_list_data.inventory_updated.disconnect(populate_item_grid)

func populate_item_grid(listed_item_list_data: ListedItemListData) -> void:
	for child in all_items_container.get_children():
		child.queue_free()
		
	for item_data in listed_item_list_data.listed_items:
		var slot = LISTED_ITEM.instantiate()
		all_items_container.add_child(slot)
		
		slot.slot_selected.connect(listed_item_list_data.on_item_selected)
		
		if item_data:
			slot.set_slot_data(item_data)
	if all_items_container.get_children()[0]:
		all_items_container.get_children()[0].grab_focus()
