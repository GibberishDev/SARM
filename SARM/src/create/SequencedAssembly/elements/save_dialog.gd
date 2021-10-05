extends FileDialog

signal SendDir(dir)

func _ready():
	current_dir = OS.get_user_data_dir().substr(0, OS.get_user_data_dir().find("Roaming")+8)

func _on_FileDialog_dir_selected(dir):
	emit_signal("SendDir", dir)
