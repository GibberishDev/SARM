extends Control
export var mode = int(0) #0 - letters, 1 - numbers
func _ready():
	if mode == 0:
		$VBoxContainer/NinePatchRect/HBoxContainer2/VBoxContainer/TextEdit.text = " Only a - z and _\n are allowed!"
	if mode == 1:
		$VBoxContainer/NinePatchRect/HBoxContainer2/VBoxContainer/TextEdit.text = " Only 1 - 999\n are allowed!"
func _on_Timer_timeout():
	queue_free()
