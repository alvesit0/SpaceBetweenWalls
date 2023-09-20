extends Area2D

class_name Selector

var tile_size = 8
var animation_speed = 5
var moving = false
var move_cd = 0

@onready var placeable_hitbox_check: PlaceableHitboxCheck = $PlaceableHitboxCheck
@onready var ray: RayCast2D = $RayCast2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var upper_left_corner: Sprite2D = $UpperLeftCorner
@onready var upper_right_corner: Sprite2D = $UpperRightCorner
@onready var lower_left_corner: Sprite2D = $LowerLeftCorner
@onready var lower_right_corner: Sprite2D = $LowerRightCorner

var targeted_placeable: Placeable
var colliding_bodies: Array[Placeable]

var inputs = {"dpad_right": Vector2.RIGHT,
			"dpad_left": Vector2.LEFT,
			"dpad_up": Vector2.UP,
			"dpad_down": Vector2.DOWN}

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size
	area_entered.connect(_on_selector_area_entered)
	area_exited.connect(_on_selector_area_exited)


func _process(_delta):
	if move_cd > 0:
		move_cd -= 1
	if moving:
		return
	for dir in inputs.keys():
		if Input.is_action_pressed(dir) \
		and PlayerManager.player.state == PlayerManager.player.States.ITEM_PLACING \
		and move_cd == 0:
			move(dir)
			
	if !targeted_placeable:
		var new_upper_left: Vector2 = collision.position
		new_upper_left.x -= 4
		new_upper_left.y -= 4
		upper_left_corner.position = new_upper_left
		
		var new_upper_right: Vector2 = collision.position
		new_upper_right.x += collision.shape.size.x
		new_upper_right.y -= 4
		upper_right_corner.position = new_upper_right
		
		var new_lower_left: Vector2 = collision.position
		new_lower_left.y += collision.shape.size.y
		new_lower_left.x -= 4
		lower_left_corner.position = new_lower_left
		
		var new_lower_right: Vector2 = collision.position
		new_lower_right.y += collision.shape.size.y
		new_lower_right.x += collision.shape.size.x
		lower_right_corner.position = new_lower_right
	else:
		var new_upper_left: Vector2 = targeted_placeable.collision.global_position
		new_upper_left.x -= targeted_placeable.collision.shape.size.x / 2
		new_upper_left.y -= targeted_placeable.collision.shape.size.y / 2
		upper_left_corner.global_position = new_upper_left
		
		var new_upper_right: Vector2 = targeted_placeable.collision.global_position
		new_upper_right.x += targeted_placeable.collision.shape.size.x
		new_upper_right.x -= targeted_placeable.collision.shape.size.x / 2
		new_upper_right.y -= targeted_placeable.collision.shape.size.y / 2
		upper_right_corner.global_position = new_upper_right
		
		var new_lower_left: Vector2 = targeted_placeable.collision.global_position
		new_lower_left.y += targeted_placeable.collision.shape.size.y
		new_lower_left.x -= targeted_placeable.collision.shape.size.x / 2
		new_lower_left.y -= targeted_placeable.collision.shape.size.y / 2
		lower_left_corner.global_position = new_lower_left
		
		var new_lower_right: Vector2 = targeted_placeable.collision.global_position
		new_lower_right.y += targeted_placeable.collision.shape.size.y
		new_lower_right.x += targeted_placeable.collision.shape.size.x
		new_lower_right.x -= targeted_placeable.collision.shape.size.x / 2
		new_lower_right.y -= targeted_placeable.collision.shape.size.y / 2
		lower_right_corner.global_position = new_lower_right
		

func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		if targeted_placeable:
			var tween_upper_left = upper_left_corner.create_tween()
			var tween_upper_right = upper_right_corner.create_tween()
			var tween_lower_left = lower_left_corner.create_tween()
			var tween_lower_right = lower_right_corner.create_tween()
			print(upper_left_corner.position + inputs[dir] * tile_size * -1)
			tween_upper_left.tween_property(upper_left_corner, "position",
				upper_left_corner.position + inputs[dir] * tile_size * -1, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
			tween_upper_right.tween_property(upper_right_corner, "position",
				upper_right_corner.position + inputs[dir] * tile_size * -1, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
			tween_lower_left.tween_property(lower_left_corner, "position",
				lower_left_corner.position + inputs[dir] * tile_size * -1, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
			tween_lower_right.tween_property(lower_right_corner, "position",
				lower_right_corner.position + inputs[dir] * tile_size * -1, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		PlayerManager.player.moving = true
		await tween.finished
		move_cd = 2
		moving = false
		PlayerManager.player.moving = false

func _on_selector_area_entered(body: Area2D) -> void:
	if body is Placeable:
		targeted_placeable = body
		colliding_bodies.append(body)
		
func _on_selector_area_exited(body: Area2D) -> void:
	if body is Placeable:
		targeted_placeable = null
		colliding_bodies.erase(body)
	if colliding_bodies.size() > 0:
		targeted_placeable = colliding_bodies[0]

