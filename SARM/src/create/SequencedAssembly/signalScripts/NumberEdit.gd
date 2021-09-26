extends TextEdit

export(PackedScene) var warnPopUp

var previous_text = ""

signal successfulText(text)

func _ready():
	emit_signal("successfulText", "1")

func textChanged():
	if text.length() > 0:
		if text[text.length()-1].is_valid_integer():
			if int(text) > 0 and int(text) <= 1000000000:
				previous_text = text
				emit_signal("successfulText", previous_text)
			elif int(text) > 1000000000:
				text = previous_text
				cursor_set_column(999)
				emit_signal("successfulText", previous_text)
				var newWarn = warnPopUp.instance()
				newWarn.rect_position = rect_global_position + Vector2(0, 24)
				newWarn.mode = 1
				get_tree().get_current_scene().add_child(newWarn)
			else:
				text = previous_text
				cursor_set_column(999)
				var newWarn = warnPopUp.instance()
				newWarn.rect_position = rect_global_position + Vector2(0, 24)
				newWarn.mode = 1
				get_tree().get_current_scene().add_child(newWarn)
		else:
			text = previous_text
			cursor_set_column(999)
			var newWarn = warnPopUp.instance()
			newWarn.rect_position = rect_global_position + Vector2(0, 24)
			newWarn.mode = 1
			get_tree().get_current_scene().add_child(newWarn)
	else:
		previous_text = "1"
		emit_signal("successfulText", "1")

