extends Node2D

func _ready():
	await Transition.resolve()
