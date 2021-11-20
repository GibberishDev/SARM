extends Control
export var mode = int(0)
func _ready():
	match mode:
		0:
			$VBoxContainer/NinePatchRect/HBoxContainer2/VBoxContainer/TextEdit.text = " Only a - z, 0 - 9\n and _ \n are allowed!"
		1:
			$VBoxContainer/NinePatchRect/HBoxContainer2/VBoxContainer/TextEdit.text = " Only 1 - 1000000000\n are allowed!"
		2:
			$VBoxContainer/NinePatchRect/HBoxContainer2/VBoxContainer/TextEdit.text = " Only a - z, 0 - 9, /\n and _ \n are allowed!"
		3:
			$VBoxContainer/NinePatchRect/HBoxContainer2/VBoxContainer/TextEdit.text = " Only 0 - 9\n and one . \n are allowed!"
		5:
			$VBoxContainer/NinePatchRect/HBoxContainer2/VBoxContainer/TextEdit.text = " Only letters, numbers\n and _ \n are allowed!"
		6:
			$VBoxContainer/NinePatchRect/HBoxContainer2/VBoxContainer/TextEdit.text = " Please specify\n file name!"
		7:
			$VBoxContainer/NinePatchRect/HBoxContainer2/VBoxContainer/TextEdit.text = " File saved"
		8:
			$VBoxContainer/NinePatchRect/HBoxContainer2/VBoxContainer/TextEdit.text = " Please specify\n file path!"
		9:
			$VBoxContainer/NinePatchRect/HBoxContainer2/VBoxContainer/TextEdit.text = " Only 1 - 16\n are allowed!"
func _on_Timer_timeout():
	queue_free()
