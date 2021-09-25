extends TextureButton

var maximized = bool(false)
var last_pos = Vector2()
onready var titlebar = get_tree().get_current_scene().get_node("Control/bgOverlay/TitleBar/HBoxContainer/header_ninePatch/titlebarHitbox")

func onButtonPress():
	if maximized == false:
		last_pos = OS.window_position
		OS.window_position = Vector2(0,0)
		OS.window_size = OS.get_screen_size() - Vector2(0, 1)
		titlebar.immovable = true
	else:
		OS.window_position = last_pos
		OS.window_size = Vector2(1024, 600)
		titlebar.immovable = false
	maximized = !maximized
	
