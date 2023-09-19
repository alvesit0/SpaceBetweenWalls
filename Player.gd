extends Node

class_name Player

signal toggle_menu

var money: int
var placetimer: int
@export var moving: bool
@export var item_list_data: ListedItemListData
@export var selected_placeable: PlaceableData

enum States {
	ITEM_PLACING,
	MOVING,
	MENU_OPENED,
	ITEM_LIST_OPENED
}

var state: States

func _ready():
	PlayerManager.player = self
	state = States.ITEM_PLACING
	moving = false
	placetimer = 0

func _physics_process(_delta):
	print(state)
	if Input.is_action_just_pressed("gboy_start") and !moving:
		toggle_menu.emit()
	if placetimer > 0:
		placetimer -= 1
