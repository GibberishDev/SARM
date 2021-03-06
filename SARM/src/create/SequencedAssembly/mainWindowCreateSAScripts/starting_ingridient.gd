extends VBoxContainer

var tagMode = bool(false) #false - item, true - tag
var identifierKeyText = ""
var identifierValueText = ""

func onToggleModePressed():
	tagMode = !tagMode
	if tagMode == true:
		$idLine/identifierLabel.text = "[MODID]:[TAG]"
	else:
		$idLine/identifierLabel.text = "[MODID]:[TAG]"

func changeIKT(text: String) -> void:
	identifierKeyText = text

func changeIVT(text: String) -> void:
	identifierValueText = text
