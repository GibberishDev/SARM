extends LineEdit

export(PackedScene) var warnPopUp

var previous_text = ""
var allowedID = "abcdefghijklmnopqrstuvwxyz_/0123456789"

signal successfulText(text)

func textChanged(_new_text):
	if text.length() > 0:
		if text[text.length() - 1] in allowedID:
			previous_text = text
			emit_signal("successfulText", previous_text)
		elif text[text.length() - 1] in "	":
			if Input.is_key_pressed(KEY_SHIFT):
				text = previous_text
				ui_previous()
			else:
				text = previous_text
				ui_next()
		else:
			text = previous_text
			set_cursor_position(999)
			var newWarn = warnPopUp.instance()
			newWarn.rect_position = rect_global_position + Vector2(0, 24)
			newWarn.mode = 2
			get_tree().get_current_scene().add_child(newWarn)
	else:
		previous_text = ""
		emit_signal("successfulText", "")

func ui_next():
	if focus_next != "":
		get_node(focus_next).grab_focus()
	else:
		pass
	
func ui_previous():
	if focus_previous != "":
		get_node(focus_previous).grab_focus()
	else:
		pass
