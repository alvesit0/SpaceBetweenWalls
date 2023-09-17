extends Node

class_name Player

signal toggle_menu

var money: int
@export var item_list_data: ListedItemListData
@export var selected_placeable: PlaceableData

func _ready():
	PlayerManager.player = self

func _physics_process(_delta):
	if Input.is_action_just_pressed("gboy_start"):
		toggle_menu.emit()
