tool
extends Control
export var numberOfPanels = int(2)
func _process(_delta):
	rect_size.y = 192 * numberOfPanels
