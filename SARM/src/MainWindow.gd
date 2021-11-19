extends Node
func _ready():
	OS.window_fullscreen = false
func show_recipes() -> void:
	$AnimationPlayer.play("slideIn")
func hide_recipes() -> void:
	$AnimationPlayer.play_backwards("slideIn")
