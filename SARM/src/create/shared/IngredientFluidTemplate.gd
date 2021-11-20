extends VBoxContainer

func _ready():
	$HBoxContainer/Label.text = name

func load_default_potion_nbt() -> void:
	$HBoxContainer/VBoxContainer/Control3/HBoxContainer/TextEdit.text = """{"Bottle": "REGULAR", "Potion": "[REPLACE WITH POTION ID]"}"""

func get_ingredient_text() -> String:
	var ingredient_text = """		{\n			"fluid": \""""
	ingredient_text += $HBoxContainer/VBoxContainer/Control/HBoxContainer/modid.text + ":" + $HBoxContainer/VBoxContainer/Control/HBoxContainer/identifier.text + "\",\n"
	if $HBoxContainer/VBoxContainer/Control3/HBoxContainer/TextEdit.text == "":
		ingredient_text += """			"nbt": {},\n"""
	else:
		ingredient_text += ("""			"nbt": """ + $HBoxContainer/VBoxContainer/Control3/HBoxContainer/TextEdit.text).replace("\n", " ") + ",\n"
	ingredient_text += """			"amount": """ + $HBoxContainer/VBoxContainer/Control2/HBoxContainer/amount.text + "\n		}"
	return ingredient_text
