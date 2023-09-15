extends Area2D

var tile_size = 8
var animation_speed = 5
var moving = false

@onready var ray = $RayCast2D

var inputs = {"dpad_right": Vector2.RIGHT,
			"dpad_left": Vector2.LEFT,
			"dpad_up": Vector2.UP,
			"dpad_down": Vector2.DOWN}

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size

func _unhandled_input(event):
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		#position += inputs[dir] * tile_size
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + inputs[dir] *    tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		moving = false

