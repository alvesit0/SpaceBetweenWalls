extends Node2D

class_name Ship

@export var tile_map_placeables: TileMap
@export var selector: Selector

func _ready() -> void:
	tile_map_placeables.selector = selector

func _process(delta) -> void:
	tile_map_placeables._process(delta)
