extends Ship

@export var selector: Selector

func _ready():
	get_parent().selector = selector
	await Transition.resolve()
	PlayerManager.player.state = PlayerManager.player.States.ITEM_PLACING
	PlayerManager.player.placed_placeables.clear()
	PlayerManager.player.funds = 1500
