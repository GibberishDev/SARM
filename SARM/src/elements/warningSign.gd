extends Control
export var mode = int(0) #0 - letters, 1 - numbers
func _ready():
	if mode == 0:
		$VBoxContainer/NinePatchRect/HBoxContainer2/VBoxContainer/TextEdit.text = " Only a - z\n and _\n are allowed!"
	if mode == 1:
		$VBoxContainer/NinePatchRect/HBoxContainer2/VBoxContainer/TextEdit.text = " Only\n 1 - 999\n are allowed!"
func close():
	queue_free()
func _on_Timer_timeout():
	queue_free()
