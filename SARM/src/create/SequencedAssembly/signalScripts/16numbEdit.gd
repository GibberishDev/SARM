extends LineEdit

export(PackedScene) var warnPopUp

var previous_text = ""

signal successfulText(text)

func _ready():
	emit_signal("successfulText", "1")

func textChanged(_new_text):
	if text.length() > 0:
		if text[text.length()-1].is_valid_integer():
			if int(text) > 0 and int(text) <= 16:
				previous_text = text
				emit_signal("successfulText", previous_text)
			elif int(text) > 16:
				text = previous_text
				set_cursor_position(999)
				emit_signal("successfulText", previous_text)
				var newWarn = warnPopUp.instance()
				newWarn.rect_position = rect_global_position + Vector2(128, 24)
				newWarn.mode = 9
				get_tree().get_current_scene().add_child(newWarn)
			else:
				text = previous_text
				set_cursor_position(999)
				var newWarn = warnPopUp.instance()
				newWarn.rect_position = rect_global_position + Vector2(128, 24)
				newWarn.mode = 9
				get_tree().get_current_scene().add_child(newWarn)
		else:
			text = previous_text
			set_cursor_position(999)
			var newWarn = warnPopUp.instance()
			newWarn.rect_position = rect_global_position + Vector2(128, 24)
			newWarn.mode = 9
			get_tree().get_current_scene().add_child(newWarn)
	else:
		previous_text = "1"
		emit_signal("successfulText", "1")
