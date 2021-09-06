extends Control
export var mode = int(0) #0 - letters, 1 - numbers, 2 - tag
func _ready():
	match mode:
		0:
			$VBoxContainer/NinePatchRect/HBoxContainer2/VBoxContainer/TextEdit.text = " Only a - z and _\n are allowed!"
		1:
			$VBoxContainer/NinePatchRect/HBoxContainer2/VBoxContainer/TextEdit.text = " Only 1 - 999\n are allowed!"
		2:
			$VBoxContainer/NinePatchRect/HBoxContainer2/VBoxContainer/TextEdit.text = " Only a - z, / and _\n are allowed!"
func _on_Timer_timeout():
	queue_free()
