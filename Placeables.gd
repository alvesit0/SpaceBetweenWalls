extends TileMap
	
@export var selector: Area2D

func _process(_delta) -> void:
	if selector:
		if (Input.is_action_just_pressed("gboy_a")):
			var tile = local_to_map(selector.global_position)
			set_cell(0, tile, 5, Vector2(6, 0), 0)
		if (Input.is_action_just_pressed("gboy_b")):
			var tile = local_to_map(selector.global_position)
			set_cell(0, tile)
