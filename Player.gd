extends Node

class_name Player

signal toggle_menu

var placetimer: int
var current_day: int
var earnings: int
var funds: int
var placed_placeables: Array[PlaceableData]
@export var moving: bool
@export var item_list_data: ListedItemListData
@export var selected_placeable: PlaceableData

enum States {
	MAIN_MENU,
	WATCHING_CUTSCENE,
	ITEM_PLACING,
	MOVING,
	MENU_OPENED,
	ITEM_LIST_OPENED,
	ZOOMED_OUT,
	ON_CONFIRM_WINDOW
}

var state: States

func _ready():
	PlayerManager.player = self
	state = States.ITEM_PLACING
	moving = false
	placetimer = 0
	current_day = 1
	earnings = 0
	funds = 0

func _physics_process(_delta):
	if Input.is_action_just_pressed("gboy_start") \
	and state != States.ITEM_LIST_OPENED \
	and !moving:
		toggle_menu.emit()
	if placetimer > 0:
		placetimer -= 1
		
func remove_funds(value: int) -> bool:
	if value > funds:
		return false
	else:
		funds -= value
		return true
		
func add_funds(value: int) -> void:
	funds += value
