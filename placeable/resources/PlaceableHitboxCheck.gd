extends Area2D

class_name PlaceableHitboxCheck

@export var collision: CollisionShape2D
var colliding_bodies: Array[Placeable]
var colliding: bool

func _ready():
	area_entered.connect(_on_hitbox_check_area_entered)
	area_exited.connect(_on_hitbox_check_area_exited)

func _physics_process(_delta):
	var rotation: RotatedPlaceableData = PlayerManager.player.selected_placeable.current_rotation
	
	collision.shape.size = rotation.dimensions
	collision.position.x = collision.shape.size.x / 2
	collision.position.y = collision.shape.size.y / 2

func _on_hitbox_check_area_entered(body: Area2D) -> void:
	if body is Placeable:
		colliding = true
		colliding_bodies.append(body)
	
func _on_hitbox_check_area_exited(body: Area2D) -> void:
	if body is Placeable:
		colliding_bodies.erase(body)
	if colliding_bodies.size() == 0:
		colliding = false
