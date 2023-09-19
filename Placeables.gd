extends TileMap
	
@export var selector: Selector
@onready var PLACEABLE_SCENE = preload("res://placeable/resources/placeable.tscn")

func _input(event):
	if selector:
		if Input.is_action_just_pressed("gboy_a") \
		and PlayerManager.player.state == PlayerManager.player.States.ITEM_PLACING:
			var initial_tile = local_to_map(selector.global_position)
			place_placeable(initial_tile)
		if Input.is_action_just_pressed("gboy_b") \
		and PlayerManager.player.state == PlayerManager.player.States.ITEM_PLACING:
			var tile = local_to_map(selector.global_position)
			set_cell(0, tile)
		if Input.is_action_just_pressed("gboy_select") \
		and PlayerManager.player.state == PlayerManager.player.States.ITEM_PLACING:
			rotate_selected()

func place_placeable(initial_tile: Vector2i) -> void:
	var placeable = PLACEABLE_SCENE.instantiate()
	get_parent().add_child(placeable)
	placeable.global_position = selector.global_position
	placeable.place(initial_tile)

func place_object() -> void:
	var object_coords: Array[Vector2] = PlayerManager.player.selected_placeable.current_rotation.tiles
	var initial_tile = local_to_map(selector.global_position)
	var distance: Vector2
	distance.x = initial_tile.x - object_coords[0].x
	distance.y = initial_tile.y - object_coords[0].y
	for i in range(object_coords.size()):
		var new_coord: Vector2 = distance
		new_coord.x += object_coords[i].x
		new_coord.y += object_coords[i].y
		set_cell(0, new_coord, 5, object_coords[i], 0)

func rotate_selected() -> void: 
	PlayerManager.player.selected_placeable._rotate()
