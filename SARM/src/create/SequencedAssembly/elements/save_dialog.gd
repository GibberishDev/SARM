extends FileDialog

signal SendDir(dir)

func _ready():
	current_dir = OS.get_user_data_dir()[0] + ":/"

func _on_FileDialog_dir_selected(dir):
	emit_signal("SendDir", dir)
