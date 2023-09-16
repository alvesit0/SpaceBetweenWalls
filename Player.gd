extends Node

class_name Player

signal toggle_inventory

var money: int
@export var item_list_data: ItemListData
@export var selected_placeable: PlaceableData

func _ready():
	PlayerManager.player = self
