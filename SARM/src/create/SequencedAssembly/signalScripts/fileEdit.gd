extends LineEdit

export(PackedScene) var warnPopUp

var previous_text = ""
var allowedID = "abcdefghijklmnopqrstuvwxyz_0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"

signal successfulText(text)

func textChanged(_new_text):
	if text.length() > 0:
		if text[text.length() - 1] in allowedID:
			previous_text = text
			emit_signal("successfulText", previous_text)
		else:
			text = previous_text
			set_cursor_position(999)
			var newWarn = warnPopUp.instance()
			newWarn.rect_position = rect_global_position + Vector2(0, 24)
			newWarn.mode = 5
			get_tree().get_current_scene().add_child(newWarn)
	else:
		previous_text = ""
		emit_signal("successfulText", "")


