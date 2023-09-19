extends Node2D

class_name Placeable

@export var tilemap: TileMap

func place(initial_pos: Vector2i):
	print("placing...")
	tilemap.clear()
	var object_coords: Array[Vector2] = PlayerManager.player.selected_placeable.current_rotation.tiles
	var initial_tile = Vector2i(0, 0)
	var distance: Vector2
	distance.x = initial_tile.x - object_coords[0].x
	distance.y = initial_tile.y - object_coords[0].y
	for i in range(object_coords.size()):
		var new_coord: Vector2 = distance
		new_coord.x += object_coords[i].x
		new_coord.y += object_coords[i].y
		print(object_coords[i])
		print(new_coord)
		tilemap.set_cell(0, new_coord, 0, object_coords[i], 0)
