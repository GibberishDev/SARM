extends Control

export var changing_size = bool()
export var size = Vector2()
var orig_size = Vector2()

func _process(delta):
	if changing_size:
		OS.window_size = size
		if size == Vector2(0, 0):
			OS.window_minimized = true

func get_orig_size() -> void:
	orig_size = OS.window_size

func set_orig_size() -> void:
	OS.window_size = orig_size

func start_anim() -> void:
	$AnimationPlayer.play("minimize")

func _unhandled_key_input(event):
	if Input.is_key_pressed(KEY_O):
		start_anim()
