extends Control

export var changing_size = bool()
export var size = Vector2()
var orig_size = Vector2()

func _process(_delta):
	if changing_size:
		OS.window_size = size
		if size == Vector2(0, 0):
			OS.window_minimized = true

func get_orig_size() -> void:
	orig_size = OS.window_size

func set_orig_size() -> void:
	OS.window_size = orig_size

func start_anim() -> void:
	if OS.window_fullscreen:
		OS.window_minimized = true
	else:
		get_orig_size()
		var anim_track = $AnimationPlayer.get_animation("minimize").find_track(".:size")
		$AnimationPlayer.get_animation("minimize").track_set_key_value(anim_track, 0, orig_size)
		$AnimationPlayer.play("minimize")
		$Timer.start()
		
