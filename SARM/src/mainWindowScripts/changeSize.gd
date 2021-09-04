extends NinePatchRect

var maximized = bool(false)
var last_pos = Vector2()

func onButtonPress():
	if maximized == false:
		last_pos = OS.window_position
		OS.window_position = Vector2(0, 0)
		OS.window_size = OS.get_screen_size()
	else:
		OS.window_position = last_pos
		OS.window_size = Vector2(1024, 600)
	maximized = !maximized
	
