extends TextureButton

var maximized = bool(false)
var last_pos = Vector2()

func onButtonPress():
	if maximized == false:
		last_pos = OS.window_position
		OS.window_fullscreen = true
	else:
		OS.window_fullscreen = false
		OS.window_position = last_pos
		OS.window_size = Vector2(1024, 600)
	maximized = !maximized
	
