extends Control

var folowing = false
var origin_pos = Vector2()

func HitBoxInput(event):
	if event is InputEventMouseButton:
		folowing = !folowing
		origin_pos = get_local_mouse_position()

func _process(delta):
	
	if folowing:
		OS.window_position = OS.window_position + get_global_mouse_position() - origin_pos
