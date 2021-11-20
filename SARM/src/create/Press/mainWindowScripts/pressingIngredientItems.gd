extends Control

var text
var tag_mode = bool(false) #false - item, true - tag


func get_text() -> String:
	text = """	"ingredients": [\n"""
	if tag_mode:
		text += "		{\"tag\": \""
	else:
		text += "		{\"item\": \""
	text += $Ingredients/idLine/identifierKey.text + ":" + $Ingredients/idLine/identifierValue.text + "\"}\n	]"
	return text


func change_tag_mode(state) -> void:
	tag_mode = state
	if state:
		$Ingredients/idLine/identifierLabel.text = "[MODID]:[TAG]"
	else:
		$Ingredients/idLine/identifierLabel.text = "[MODID]:[IDENTIFIER]"
