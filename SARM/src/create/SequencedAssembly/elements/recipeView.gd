extends Control

export(PackedScene) var warn
export(PackedScene) var warnName

var fullDir = ""
var recipe = ""
var Dir = ""

func _ready():
	if Dir == "":
		match OS.get_name():
			"Windows":
				Dir = OS.get_user_data_dir().substr(0, 2) + $FileDialog.current_dir
			"X11":
				Dir = "~/.minecraft"
	$RecipeWindow/HBoxContainer2/RecipeBoundry/HBoxContainer/VBoxContainer/HBoxContainer2/filePath.text = Dir
	$FileDialog.current_dir = Dir
	$RecipeWindow.rect_size = OS.window_size - Vector2(64, 64)
	$RecipeWindow.rect_position = Vector2(32, 32)
	$RecipeWindow/HBoxContainer2/RecipeBoundry/HBoxContainer/VBoxContainer/recipe.text = recipe
func close():
	queue_free()

func save_file(dir: String):
	Dir = dir
	get_tree().get_current_scene().dir = dir
	$RecipeWindow/HBoxContainer2/RecipeBoundry/HBoxContainer/VBoxContainer/HBoxContainer2/filePath.text = dir

func Save():
	var newWarnName = warnName.instance()
	if $RecipeWindow/HBoxContainer2/RecipeBoundry/HBoxContainer/VBoxContainer/HBoxContainer/fileName.text == "":
		newWarnName.mode = 6
		newWarnName.rect_position = OS.window_size/2 - Vector2(128, 64)
		add_child(newWarnName)
	else:
		fullDir = Dir + "/" + $RecipeWindow/HBoxContainer2/RecipeBoundry/HBoxContainer/VBoxContainer/HBoxContainer/fileName.text + ".json"
		if Dir == "":
			newWarnName.mode = 8
			newWarnName.rect_position = OS.window_size/2 - Vector2(128, 64)
			add_child(newWarnName)
		else:
			var file = File.new()
			if file.file_exists(fullDir) == true:
				file.close()
				var newWarn = warn.instance()
				newWarn.Text = recipe
				newWarn.fileDir = fullDir
				add_child(newWarn)
			else:
				file.open(fullDir, File.WRITE)
				file.store_string(recipe)
				file.close()
				newWarnName.rect_position = OS.window_size/2 - Vector2(128, 64)
				newWarnName.mode = 7
				add_child(newWarnName)


func openSaveFile():
	$FileDialog.popup_centered()
