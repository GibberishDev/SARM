extends Control

export var Number_of_mods = int(1)

func _ready():
	rect_min_size.y = Number_of_mods * 192
