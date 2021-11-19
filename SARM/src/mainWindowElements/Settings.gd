extends Control
var settings_dict = {
	"animations": true,
	"preview_shown": true,
	"preview_lighting": true,
	"minimized_view_resolution": "1024, 600"
}

#func _ready():
#	print(OS.get_user_data_dir() + "/settings.json")
#	var settings_file = File.new()
#	print(settings_file.file_exists(OS.get_user_data_dir() + "/settings.json"))
#	if settings_file.file_exists(OS.get_user_data_dir() + "/settings.json") == false:
#		settings_file.open(OS.get_user_data_dir() + "/settings.json", File.WRITE)
#		settings_file.store_string(str(settings_dict))
#		settings_file.close()
#
#
