extends Control

var folowing = false
var origin_pos = Vector2()
var immovable = false

func _on_titlebar_gui_input(event):
	if event is InputEventMouseButton and immovable == false:
		folowing = !folowing
		origin_pos = get_local_mouse_position()

func _process(delta):
	
	if folowing:
		OS.window_position = OS.window_position + get_global_mouse_position() - origin_pos
