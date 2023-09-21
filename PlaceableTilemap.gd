extends TileMap
	
@export var selector: Selector
@onready var PLACEABLE_SCENE = preload("res://placeable/resources/placeable.tscn")

func _input(event):
	if selector:
		if Input.is_action_just_pressed("gboy_a") \
		and PlayerManager.player.state == PlayerManager.player.States.ITEM_PLACING \
		and PlayerManager.player.placetimer == 0 \
		and !PlayerManager.player.moving:
			var initial_tile = local_to_map(selector.global_position)
			place_placeable(initial_tile)
		if Input.is_action_just_pressed("gboy_b") \
		and PlayerManager.player.state == PlayerManager.player.States.ITEM_PLACING \
		and !PlayerManager.player.moving:
			remove_placeable()
		if Input.is_action_just_pressed("gboy_select") \
		and PlayerManager.player.state == PlayerManager.player.States.ITEM_PLACING:
			rotate_selected()

func place_placeable(initial_tile: Vector2i) -> void:
	if PlayerManager.player.selected_placeable:
		var placeable = PLACEABLE_SCENE.instantiate()
		placeable.global_position = selector.global_position
		placeable.update_data()
		add_child(placeable)
		if selector.placeable_hitbox_check.colliding:
			placeable.queue_free()
	elif selector.targeted_placeable:
		PlayerManager.player.selected_placeable = selector.targeted_placeable.data
		selector.targeted_placeable.queue_free()

func remove_placeable() -> void:
	if PlayerManager.player.selected_placeable:
		PlayerManager.player.selected_placeable = null
	elif selector.targeted_placeable:
		selector.targeted_placeable.queue_free()

func rotate_selected() -> void: 
	if PlayerManager.player.selected_placeable:
		PlayerManager.player.selected_placeable._rotate()
