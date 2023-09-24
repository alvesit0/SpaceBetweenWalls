extends TileMap
	
@export var selector: Selector
@onready var PLACEABLE_SCENE = preload("res://placeable/resources/placeable.tscn")

@onready var place_sound = $PlaceSound
@onready var rotate_sound = $RotateSound
@onready var move_sound = $MoveSound

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
		if selector.placeable_hitbox_check.colliding \
		or !PlayerManager.player.remove_funds(placeable.data.price):
			placeable.queue_free()
		else:
			place_sound.play()
			PlayerManager.player.placed_placeables.append(placeable.data)
	elif selector.targeted_placeable:
		move_sound.play()
		PlayerManager.player.add_funds(selector.targeted_placeable.data.price)
		PlayerManager.player.selected_placeable = selector.targeted_placeable.data
		PlayerManager.player.placed_placeables.erase(selector.targeted_placeable.data)
		selector.targeted_placeable.queue_free()

func remove_placeable() -> void:
	if PlayerManager.player.selected_placeable:
		PlayerManager.player.selected_placeable = null
	elif selector.targeted_placeable:
		PlayerManager.player.add_funds(selector.targeted_placeable.data.price)
		PlayerManager.player.placed_placeables.erase(selector.targeted_placeable.data)
		selector.targeted_placeable.queue_free()

func rotate_selected() -> void: 
	if PlayerManager.player.selected_placeable:
		rotate_sound.play()
		PlayerManager.player.selected_placeable._rotate()
