extends TextEdit

export(PackedScene) var warnPopUp

var previous_text = ""
var allowedID = "0123456789."

signal successfulText(text)

func textChanged():
	if text.length() > 0:
		if text[text.length() - 1] in allowedID:
			if text.count(".") == 1 or text.count(".") == 0:
				previous_text = text
				emit_signal("successfulText", previous_text)
			else:
				text = previous_text
				cursor_set_column(999)
				var newWarn = warnPopUp.instance()
				newWarn.rect_position = rect_global_position + Vector2(- 256 + 128, 24)
				newWarn.mode = 3
				get_tree().get_current_scene().add_child(newWarn)
		else:
			text = previous_text
			cursor_set_column(999)
			var newWarn = warnPopUp.instance()
			newWarn.rect_position = rect_global_position + Vector2(- 256 + 128, 24)
			newWarn.mode = 3
			get_tree().get_current_scene().add_child(newWarn)
	else:
		previous_text = ""
		emit_signal("successfulText", "")

