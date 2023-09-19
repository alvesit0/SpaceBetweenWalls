extends Area2D

class_name Selector

var tile_size = 8
var animation_speed = 5
var moving = false

@onready var placeable_hitbox_check: PlaceableHitboxCheck = $PlaceableHitboxCheck
@onready var ray: RayCast2D = $RayCast2D
var targeted_placeable: Placeable

var inputs = {"dpad_right": Vector2.RIGHT,
			"dpad_left": Vector2.LEFT,
			"dpad_up": Vector2.UP,
			"dpad_down": Vector2.DOWN}

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size
	area_entered.connect(_on_selector_area_entered)
	area_exited.connect(_on_selector_area_exited)
	
func _physics_process(delta):
	pass

func _process(_delta):
	if moving:
		return
	for dir in inputs.keys():
		if Input.is_action_pressed(dir) \
		and PlayerManager.player.state == PlayerManager.player.States.ITEM_PLACING:
			move(dir)

func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + inputs[dir] *    tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		PlayerManager.player.moving = true
		await tween.finished
		moving = false
		PlayerManager.player.moving = false

func _on_selector_area_entered(body: Area2D) -> void:
	if body is Placeable:
		targeted_placeable = body
		
func _on_selector_area_exited(body: Area2D) -> void:
	if body is Placeable:
		targeted_placeable = null

