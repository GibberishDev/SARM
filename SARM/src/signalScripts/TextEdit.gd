extends TextEdit

var previous_text = ""
var allowedID = "abcdefghijklmnopqrstuvwxyz_"

signal successfulText(text)

func textChanged():
	if text.length() > 0 and text.length() < 999:
		if text[text.length() - 1] in allowedID:
			previous_text = text
			emit_signal("successfulText", previous_text)
		else:
			text = previous_text
			cursor_set_column(999)

