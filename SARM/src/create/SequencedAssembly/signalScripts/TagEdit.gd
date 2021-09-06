extends TextEdit

export(PackedScene) var warnPopUp

var previous_text = ""
var allowedID = "abcdefghijklmnopqrstuvwxyz_/"

signal successfulText(text)

func textChanged():
	if text.length() > 0:
		if text[text.length() - 1] in allowedID:
			previous_text = text
			emit_signal("successfulText", previous_text)
		else:
			text = previous_text
			cursor_set_column(999)
			var newWarn = warnPopUp.instance()
			newWarn.rect_position = rect_global_position + Vector2(0, 18)
			newWarn.mode = 2
			get_tree().get_current_scene().add_child(newWarn)
	else:
		previous_text = ""
		emit_signal("successfulText", "")

