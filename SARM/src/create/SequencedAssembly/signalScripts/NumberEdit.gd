extends LineEdit

export(PackedScene) var warnPopUp

var previous_text = ""

signal successfulText(text)

func _ready():
	emit_signal("successfulText", "1")

func textChanged(_new_text):
	if text.length() > 0:
		if text[text.length()-1].is_valid_integer():
			if int(text) > 0 and int(text) <= 1000000000:
				previous_text = text
				emit_signal("successfulText", previous_text)
			elif int(text) > 1000000000:
				text = previous_text
				set_cursor_position(999)
				emit_signal("successfulText", previous_text)
				var newWarn = warnPopUp.instance()
				newWarn.rect_position = rect_global_position + Vector2(- 256 + 128, 24)
				newWarn.mode = 1
				get_tree().get_current_scene().add_child(newWarn)
			elif text[text.length() - 1] in "	":
				if Input.is_key_pressed(KEY_SHIFT):
					ui_previous()
				else:
					ui_next()
			else:
				text = previous_text
				set_cursor_position(999)
				var newWarn = warnPopUp.instance()
				newWarn.rect_position = rect_global_position + Vector2(- 256 + 128, 24)
				newWarn.mode = 1
				get_tree().get_current_scene().add_child(newWarn)
		else:
			text = previous_text
			set_cursor_position(999)
			var newWarn = warnPopUp.instance()
			newWarn.rect_position = rect_global_position + Vector2(- 256 + 128, 24)
			newWarn.mode = 1
			get_tree().get_current_scene().add_child(newWarn)
	else:
		previous_text = "1"
		emit_signal("successfulText", "1")

func ui_next():
	get_node(focus_next).grab_focus()
	
func ui_previous():
	get_node(focus_previous).grab_focus()
