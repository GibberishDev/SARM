extends Control

var mode = int(0)

func _ready():
	randomize()
	if mode == 0:
		if randi() % 100 == 1:
			$VBoxContainer/NinePatchRect2/Label.text = "Are you sure\nyou want stop to exist?"
		else:
			$VBoxContainer/NinePatchRect2/Label.text = "Are you sure\nyou want to\nclose the\nprogram?"
	elif mode == 1:
		if randi() % 100 == 1:
			$VBoxContainer/NinePatchRect2/Label.text = "Are you sure\nyou want stop to exist?\nNo progress\nwill be saved."
		else:
			$VBoxContainer/NinePatchRect2/Label.text = "Are you sure\nyou want to exit?\nNo progress\nwill be saved."

func No():
	queue_free()
func Yes():
	if mode == 0:
		get_tree().quit()
	if mode == 1:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://src/MainWindow.tscn")
