extends Resource

class_name PlaceableData

@export var name: String
@export var available_rotations: Array[RotatedPlaceableData]
@export var current_rotation: RotatedPlaceableData
@export var price: int
@export var texture: Texture
var index: int

func _ready() -> void:
	index = 0
	current_rotation = available_rotations[index]

func _rotate():
	if index < available_rotations.size() - 1:
		index += 1
	else:
		index = 0
	
	current_rotation = available_rotations[index]


