extends Node

func _ready():
	OS.window_size = Vector2(1024, 600)
	OS.window_position = OS.get_screen_size() / 2 - Vector2(512, 300) 
