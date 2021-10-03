extends Control
export var mode = int(0) #0 - letters, 1 - numbers, 2 - tag
func _ready():
	match mode:
		0:
			$VBoxContainer/NinePatchRect/HBoxContainer2/VBoxContainer/TextEdit.text = " Only a - z, 0 - 9\n and _ \nare allowed!"
		1:
			$VBoxContainer/NinePatchRect/HBoxContainer2/VBoxContainer/TextEdit.text = " Only 1 - 1000000000\n are allowed!"
		2:
			$VBoxContainer/NinePatchRect/HBoxContainer2/VBoxContainer/TextEdit.text = " Only a - z, 0 - 9, /\n and _ \nare allowed!"
func _on_Timer_timeout():
	queue_free()
