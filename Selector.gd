extends Area2D

class_name Selector

var tile_size = 8
var animation_speed = 5
var moving = false
var move_cd = 0

const PLACEABLE_SCENE = preload("res://placeable/resources/placeable.tscn")

@onready var move_sound = $MoveSound

@onready var placeable_hitbox_check: PlaceableHitboxCheck = $PlaceableHitboxCheck
@onready var ray: RayCast2D = $RayCast2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var upper_left_corner: Sprite2D = $UpperLeftCorner
@onready var upper_right_corner: Sprite2D = $UpperRightCorner
@onready var lower_left_corner: Sprite2D = $LowerLeftCorner
@onready var lower_right_corner: Sprite2D = $LowerRightCorner
@onready var main_camera: Camera2D = $CameraPivot/Camera2D
@export var zoomed_out_camera: Camera2D

var targeted_placeable: Placeable
var colliding_bodies: Array[Placeable]
@export var preview_placeable: Placeable
var preview_placeable_timer: int

var inputs = {"dpad_right": Vector2.RIGHT,
			"dpad_left": Vector2.LEFT,
			"dpad_up": Vector2.UP,
			"dpad_down": Vector2.DOWN}

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size
	area_entered.connect(_on_selector_area_entered)
	area_exited.connect(_on_selector_area_exited)
	preview_placeable.has_shape = false
	preview_placeable.update_data()
	preview_placeable_timer = 0

func _process(delta):
	preview_placeable.update_data()
	
	if PlayerManager.player and !PlayerManager.player.selected_placeable:
		preview_placeable.visible = false
	elif preview_placeable_timer > 0:
		preview_placeable_timer -= 1
	else:
		preview_placeable_timer = 100 * delta
		preview_placeable.visible = !preview_placeable.visible
	
	if move_cd > 0:
		move_cd -= 1
	if moving:
		return
	for dir in inputs.keys():
		if Input.is_action_pressed(dir) \
		and PlayerManager.player.state == PlayerManager.player.States.ITEM_PLACING \
		and move_cd == 0:
			move(dir)
			if PlayerManager.player.selected_placeable:
				move_sound.play()
	
	if PlayerManager.player.state == PlayerManager.player.States.ZOOMED_OUT \
	and (Input.is_action_just_pressed("gboy_b") or Input.is_action_just_pressed("gboy_start")):
		toggle_camera()
		PlayerManager.player.state = PlayerManager.player.States.ITEM_PLACING
			
	if !targeted_placeable and !PlayerManager.player.selected_placeable:
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
	elif PlayerManager.player.selected_placeable:
		var new_upper_left: Vector2 = placeable_hitbox_check.collision.global_position
		new_upper_left.x -= placeable_hitbox_check.collision.shape.size.x / 2
		new_upper_left.y -= placeable_hitbox_check.collision.shape.size.y / 2
		upper_left_corner.global_position = new_upper_left
		
		var new_upper_right: Vector2 = placeable_hitbox_check.collision.global_position
		new_upper_right.x += placeable_hitbox_check.collision.shape.size.x
		new_upper_right.x -= placeable_hitbox_check.collision.shape.size.x / 2
		new_upper_right.y -= placeable_hitbox_check.collision.shape.size.y / 2
		upper_right_corner.global_position = new_upper_right
		
		var new_lower_left: Vector2 = placeable_hitbox_check.collision.global_position
		new_lower_left.y += placeable_hitbox_check.collision.shape.size.y
		new_lower_left.x -= placeable_hitbox_check.collision.shape.size.x / 2
		new_lower_left.y -= placeable_hitbox_check.collision.shape.size.y / 2
		lower_left_corner.global_position = new_lower_left
		
		var new_lower_right: Vector2 = placeable_hitbox_check.collision.global_position
		new_lower_right.y += placeable_hitbox_check.collision.shape.size.y
		new_lower_right.x += placeable_hitbox_check.collision.shape.size.x
		new_lower_right.x -= placeable_hitbox_check.collision.shape.size.x / 2
		new_lower_right.y -= placeable_hitbox_check.collision.shape.size.y / 2
		lower_right_corner.global_position = new_lower_right
	elif targeted_placeable:
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
		if targeted_placeable and !PlayerManager.player.selected_placeable:
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
		move_cd = 3
		moving = false
		PlayerManager.player.moving = false
		
func toggle_camera() -> void:
	if main_camera.enabled:
		main_camera.enabled = false
		zoomed_out_camera.enabled = true
	else:
		main_camera.enabled = true
		zoomed_out_camera.enabled = false

func _on_selector_area_entered(body: Area2D) -> void:
	if body is Placeable and body != preview_placeable:
		targeted_placeable = body
		colliding_bodies.append(body)
		
func _on_selector_area_exited(body: Area2D) -> void:
	if body is Placeable and body != preview_placeable:
		targeted_placeable = null
		colliding_bodies.erase(body)
	if colliding_bodies.size() > 0:
		targeted_placeable = colliding_bodies[0]

