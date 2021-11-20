extends VBoxContainer

var tag_mode = bool(false)
var amount = int(1)

func _ready():
	$tagModeChanger/id.text = name

func get_amount() -> int:
	if $idLine2/amount.text != "":
		amount = int($idLine2/amount.text)
	else:
		amount = 1
	return amount

func get_ingredient_text() -> String:
	var ingredient_text = "		{\""
	if tag_mode:
		ingredient_text += "tag\": \""
	else:
		ingredient_text += "item\": \""
	ingredient_text += $idLine/identifierKey.text + ":" + $idLine/identifierValue.text + "\"}"
	return ingredient_text

func change_tag_mode(state) -> void:
	tag_mode = state
	if state:
		$idLine/identifierLabel.text = "[MODID]:[TAG]"
	else:
		$idLine/identifierLabel.text = "[MODID]:[IDENTIFIER]"
