extends Area2D

class_name PlaceableHitboxCheck

@export var collision: CollisionShape2D
var colliding_bodies: Array[Node]
var colliding: bool

func _ready():
	area_entered.connect(_on_hitbox_check_area_entered)
	area_exited.connect(_on_hitbox_check_area_exited)

func _physics_process(_delta):
	if PlayerManager.player.selected_placeable:
		var rotation: RotatedPlaceableData = PlayerManager.player.selected_placeable.current_rotation
		collision.shape.size = rotation.dimensions
		collision.position.x = collision.shape.size.x / 2
		collision.position.y = collision.shape.size.y / 2
	else:
		collision.shape.size = Vector2i(8, 8)
		collision.position.x = 4
		collision.position.y = 4

func _on_hitbox_check_area_entered(body: Area2D) -> void:
	if body is Placeable or body is UnplaceableTile:
		colliding = true
		colliding_bodies.append(body)
	elif body is WallTile:
		if PlayerManager.player.selected_placeable and PlayerManager.player.selected_placeable.goes_on_wall == false:
			colliding = true
			colliding_bodies.append(body)
	elif body is FloorTile:
		if PlayerManager.player.selected_placeable and PlayerManager.player.selected_placeable.goes_on_wall == true:
			colliding = true
			colliding_bodies.append(body)

func _on_hitbox_check_area_exited(body: Area2D) -> void:
	if body is Placeable or body is UnplaceableTile:
		colliding_bodies.erase(body)
	elif body is WallTile:
		if PlayerManager.player.selected_placeable and PlayerManager.player.selected_placeable.goes_on_wall == false:
			colliding_bodies.erase(body)
	elif body is FloorTile:
		if PlayerManager.player.selected_placeable and PlayerManager.player.selected_placeable.goes_on_wall == true:
			colliding_bodies.erase(body)
	if colliding_bodies.size() == 0:
		colliding = false
	print(colliding)
	print(colliding_bodies)
