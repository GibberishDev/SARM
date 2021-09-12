extends TextureButton

var maximized = bool(false)
var last_pos = Vector2()
onready var titlebar = get_tree().get_current_scene().get_node("Control/bgOverlay/TitleBar/HBoxContainer/header_ninePatch/titlebarHitbox")

func onButtonPress():
	if maximized == false:
		titlebar.immovable = true
	else:
		titlebar.immovable = false
	OS.window_fullscreen = !OS.window_fullscreen
	maximized = !maximized
	
