extends Control
func _ready():
	randomize()
	if randi() % 100 == 1:
		$VBoxContainer/NinePatchRect2/Label.text = "Are you sure\nyou want stop to exist?\nNo progress\nwill be saved."
	else:
		$VBoxContainer/NinePatchRect2/Label.text = "Are you sure\nyou want to exit?\nNo progress\nwill be saved."

func No():
	queue_free()
func Yes():
	get_tree().quit()
