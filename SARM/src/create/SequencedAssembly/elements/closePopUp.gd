extends Control

var mode = int(0)

func _ready():
	randomize()
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
		get_tree().change_scene("res://src/MainWindow.tscn")
