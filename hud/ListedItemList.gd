extends Control

class_name ListedItemList

const LISTED_ITEM = preload("res://hud/listed_item.tscn")
const ALL_ICON = preload("res://images/item_list_icons/all_icon.png")
const ELEGANT_ICON = preload("res://images/item_list_icons/elegant_icon.png")
const MODERN_ICON = preload("res://images/item_list_icons/modern_icon.png")
const OTHERWORLDLY_ICON = preload("res://images/item_list_icons/otherworldly_icon.png")
const RUSTIC_ICON = preload("res://images/item_list_icons/rustic_icon.png")
const FUTURISTIC_ICON = preload("res://images/item_list_icons/futuristic_icon.png")

@export var all_items_container: VBoxContainer
@export var rustic_items_container: VBoxContainer
@export var elegant_items_container: VBoxContainer
@export var modern_items_container: VBoxContainer
@export var otherworldly_items_container: VBoxContainer
@export var futuristic_items_container: VBoxContainer
@export var tab_container: TabContainer
var current_tab: VBoxContainer

@onready var back_sound = $BackSound
@onready var move_sound = $MoveSound

var tabindex: int

func _ready() -> void:
	tab_container.set_tab_icon(0, ALL_ICON)
	tab_container.set_tab_icon(1, RUSTIC_ICON)
	tab_container.set_tab_icon(2, ELEGANT_ICON)
	tab_container.set_tab_icon(3, MODERN_ICON)
	tab_container.set_tab_icon(4, OTHERWORLDLY_ICON)
	tab_container.set_tab_icon(5, FUTURISTIC_ICON)
	tab_container.set_tab_title(0, "")
	tab_container.set_tab_title(1, "")
	tab_container.set_tab_title(2, "")
	tab_container.set_tab_title(3, "")
	tab_container.set_tab_title(4, "")
	tab_container.set_tab_title(5, "")
	tabindex = 0
	current_tab = all_items_container
	set_focus()
	
func _input(event):
	if Input.is_action_just_pressed("gboy_a") \
	and PlayerManager.player.state == PlayerManager.player.States.ITEM_LIST_OPENED:
		back_sound.play()
		for child in current_tab.get_children():
			if child.has_focus() and child is ListedItem:
				PlayerManager.player.selected_placeable = child.placeable_data
				PlayerManager.player.state = PlayerManager.player.States.ITEM_PLACING
				PlayerManager.player.placetimer = 5
				queue_free()
		
	if Input.is_action_just_pressed("gboy_start") \
	or Input.is_action_just_pressed("gboy_b") \
	and PlayerManager.player.state == PlayerManager.player.States.ITEM_LIST_OPENED:
		back_sound.play()
		PlayerManager.player.state = PlayerManager.player.States.ITEM_PLACING
		queue_free()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_right") \
	and PlayerManager.player.state == PlayerManager.player.States.ITEM_LIST_OPENED:
		move_sound.play()
		if tabindex == 5:
			tabindex = 0
		else:
			tabindex += 1
			
		match tabindex:
			0: current_tab = all_items_container
			1: current_tab = rustic_items_container
			2: current_tab = elegant_items_container
			3: current_tab = modern_items_container
			4: current_tab = otherworldly_items_container
			5: current_tab = futuristic_items_container
		set_focus()
		tab_container.set_current_tab(tabindex)
		
	if Input.is_action_just_pressed("ui_left")  \
	and PlayerManager.player.state == PlayerManager.player.States.ITEM_LIST_OPENED:
		move_sound.play()
		if tabindex == 0:
			tabindex = 5
		else:
			tabindex -= 1
		match tabindex:
			0: current_tab = all_items_container
			1: current_tab = rustic_items_container
			2: current_tab = elegant_items_container
			3: current_tab = modern_items_container
			4: current_tab = otherworldly_items_container
			5: current_tab = futuristic_items_container
		set_focus()
		tab_container.set_current_tab(tabindex)
	
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down"):
		move_sound.play()

func set_listed_item_list(listed_item_list_data: ListedItemListData) -> void:
	if !listed_item_list_data.is_connected("inventory_updated", populate_item_grid):
		listed_item_list_data.inventory_updated.connect(populate_item_grid)
	populate_item_grid(listed_item_list_data)
	
func set_focus() -> void:
	if current_tab.get_child(0):
		current_tab.get_child(0).grab_focus()
	
func clear_listed_item_list(listed_item_list_data: ListedItemListData) -> void:
	listed_item_list_data.inventory_updated.disconnect(populate_item_grid)

func populate_item_grid(listed_item_list_data: ListedItemListData) -> void:
	for child in all_items_container.get_children():
		if child is ListedItem:
			child.queue_free()
		
	for item_data in listed_item_list_data.listed_items:
		var slot = LISTED_ITEM.instantiate()
		all_items_container.add_child(slot)
		
		slot.slot_selected.connect(listed_item_list_data.on_item_selected)
		
		if item_data:
			slot.set_slot_data(item_data)
	
	for item_data in listed_item_list_data.rustic_listed_items:
		var slot = LISTED_ITEM.instantiate()
		rustic_items_container.add_child(slot)
		
		slot.slot_selected.connect(listed_item_list_data.on_item_selected)
		
		if item_data:
			slot.set_slot_data(item_data)
			
	for item_data in listed_item_list_data.elegant_listed_items:
		var slot = LISTED_ITEM.instantiate()
		elegant_items_container.add_child(slot)
		
		slot.slot_selected.connect(listed_item_list_data.on_item_selected)
		
		if item_data:
			slot.set_slot_data(item_data)
			
	for item_data in listed_item_list_data.modern_listed_items:
		var slot = LISTED_ITEM.instantiate()
		modern_items_container.add_child(slot)
		
		slot.slot_selected.connect(listed_item_list_data.on_item_selected)
		
		if item_data:
			slot.set_slot_data(item_data)
			
	for item_data in listed_item_list_data.futuristic_listed_items:
		var slot = LISTED_ITEM.instantiate()
		futuristic_items_container.add_child(slot)
		
		slot.slot_selected.connect(listed_item_list_data.on_item_selected)
		
		if item_data:
			slot.set_slot_data(item_data)
			
	for item_data in listed_item_list_data.otherworldly_listed_items:
		var slot = LISTED_ITEM.instantiate()
		otherworldly_items_container.add_child(slot)
		
		slot.slot_selected.connect(listed_item_list_data.on_item_selected)
		
		if item_data:
			slot.set_slot_data(item_data)
