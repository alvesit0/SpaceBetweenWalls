extends CanvasLayer

func dissolve() -> void:
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished

func resolve() -> void:
	$AnimationPlayer.play_backwards("dissolve")
	await $AnimationPlayer.animation_finished
	
func reset() -> void:
	$AnimationPlayer.play("RESET")
	await $AnimationPlayer.animation_finished
	
func resolve_no_await() -> void:
	$AnimationPlayer.play_backwards("dissolve")
