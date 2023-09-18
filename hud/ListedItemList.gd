extends Control

class_name ListedItemList

const LISTED_ITEM = preload("res://hud/listed_item.tscn")
const ALL_ICON = preload("res://question_mark.png")

@export var all_items_container: VBoxContainer
@export var tab_container: TabContainer
var tabindex: int

func _ready() -> void:
	tab_container.set_tab_icon(0, ALL_ICON)
	tab_container.set_tab_title(0, "")
	tab_container.set_tab_title(1, "R")
	tab_container.set_tab_title(2, "E")
	tab_container.set_tab_title(3, "M")
	tab_container.set_tab_title(4, "O")
	tab_container.set_tab_title(5, "F")
	tabindex = 0
	set_focus()
	
func _input(_event):
	
	if Input.is_action_just_pressed("gboy_a") \
	and PlayerManager.player.state == PlayerManager.player.States.ITEM_LIST_OPENED:
		for child in all_items_container.get_children():
			if child.has_focus() and child is ListedItem:
				PlayerManager.player.selected_placeable = child.placeable_data
				PlayerManager.player.state = PlayerManager.player.States.ITEM_PLACING
				print(PlayerManager.player.selected_placeable.name)
				queue_free()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_right") \
	and PlayerManager.player.state == PlayerManager.player.States.ITEM_LIST_OPENED:
		if tabindex == 5:
			tabindex = 0
		else:
			tabindex += 1
		set_focus()
		tab_container.set_current_tab(tabindex)
		
	if Input.is_action_just_pressed("ui_left")  \
	and PlayerManager.player.state == PlayerManager.player.States.ITEM_LIST_OPENED:
		if tabindex == 0:
			tabindex = 5
		else:
			tabindex -= 1
		set_focus()
		tab_container.set_current_tab(tabindex)

func set_listed_item_list(listed_item_list_data: ListedItemListData) -> void:
	if !listed_item_list_data.is_connected("inventory_updated", populate_item_grid):
		listed_item_list_data.inventory_updated.connect(populate_item_grid)
	populate_item_grid(listed_item_list_data)
	
func set_focus() -> void:
	if all_items_container.get_child(0):
		all_items_container.get_child(0).grab_focus()
	
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
