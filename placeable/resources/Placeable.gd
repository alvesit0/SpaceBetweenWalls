extends Area2D

class_name Placeable

@export var tilemap: TileMap
@export var collision: CollisionShape2D
var data: PlaceableData
var has_shape: bool

func _ready() -> void:
	has_shape = true
	update_data()
		
func update_data():
	if PlayerManager.player:
		data = PlayerManager.player.selected_placeable
	if PlayerManager.player and has_shape:
		collision.shape = RectangleShape2D.new()
		var rotation: RotatedPlaceableData = PlayerManager.player.selected_placeable.current_rotation
		
		collision.shape.size = rotation.dimensions
		collision.position.x = collision.shape.size.x / 2
		collision.position.y = collision.shape.size.y / 2
		print(collision.shape)
	elif !has_shape:
		collision.shape = null
	if PlayerManager.player and PlayerManager.player.selected_placeable:
		tilemap.clear()
		var rotation: RotatedPlaceableData = PlayerManager.player.selected_placeable.current_rotation
		
		var object_coords: Array[Vector2] = rotation.tiles
		var initial_tile = Vector2i(0, 0)
		var distance: Vector2
		distance.x = initial_tile.x - object_coords[0].x
		distance.y = initial_tile.y - object_coords[0].y
		for i in range(object_coords.size()):
			var new_coord: Vector2 = distance
			new_coord.x += object_coords[i].x
			new_coord.y += object_coords[i].y
			tilemap.set_cell(0, new_coord, 0, object_coords[i], 0)
