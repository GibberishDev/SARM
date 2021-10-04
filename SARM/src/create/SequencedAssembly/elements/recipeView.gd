extends Control

export(PackedScene) var warn
export(PackedScene) var warnName

var fullDir = ""
var recipe = ""
var Dir = ""

func _ready():
	$RecipeWindow.rect_size = OS.window_size - Vector2(64, 64)
	$RecipeWindow.rect_position = Vector2(32, 32)
	$RecipeWindow/HBoxContainer2/RecipeBoundry/HBoxContainer/VBoxContainer/recipe.text = recipe
func close():
	queue_free()

func save_file(dir: String):
	Dir = dir

func Save():
	if $RecipeWindow/HBoxContainer2/RecipeBoundry/HBoxContainer/VBoxContainer/HBoxContainer2/fileName.text == "":
		var newWarnName = warnName.instance()
		newWarnName.mode = 6
		add_child(newWarnName)
	else:
		fullDir = Dir + "/" + $RecipeWindow/HBoxContainer2/RecipeBoundry/HBoxContainer/VBoxContainer/HBoxContainer2/fileName.text + ".json"
	var file = File.new()
	if fullDir == "" or fullDir == null:
		var newWarnName = warnName.instance()
		newWarnName.mode = 8
		add_child(newWarnName)
	else:
		print(fullDir)
		if file.file_exists(fullDir) == true:
			file.close()
			var newWarn = warn.instance()
			newWarn.Text = recipe
			newWarn.fileDir = fullDir
			add_child(newWarn)
			newWarn.save()
		else:
			file.open(fullDir, File.WRITE)
			file.store_string(recipe)
			file.close()
			var newWarnName = warnName.instance()
			newWarnName.mode = 7
			add_child(newWarnName)

func openSaveFile():
	$FileDialog.popup_centered()
