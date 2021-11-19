extends Node

export(PackedScene) var recipeTextScene

var dir

var recipe = ""

const createPStartingText = """{
	\"credit\": \"Made using SARM tool by GibberishDev\",
	"""

var recipe_type = int(0) #0 - pressing recipe, 1 - compacting recipe

var ingredients_text = ""

func gen_text() -> void:
	recipe = ""
	recipe = createPStartingText
	match recipe_type:
		0:
			recipe += "\"type\": \"create:pressing\",\n"
		1:
			recipe += "\"type\": \"create:compacting\",\n"
	recipe += "	\"ingredients\": [\n"
	recipe += get_ingredients_text()
	recipe += "	],\n"
	recipe += "	\"results\": [\n"
	recipe += get_result_item()
	recipe += "	]\n}"
	showRecipeWindow(recipe)

func get_ingredients_text() -> String:
	var text = ""
	match recipe_type:
		0:
			text = $Interface/VBoxContainer/MainFrame/Control/VBoxContainer/pressing.get_text()
		1:
			text = $Interface/VBoxContainer/MainFrame/Control/VBoxContainer/basinContents.get_text()
	return text

func get_result_item() -> String:
	var text = ""
	text = "		{\"item\": \"" + $Interface/VBoxContainer/MainFrame/Control/VBoxContainer/ResultItem/idLine/identifierKey.text + ":" + $Interface/VBoxContainer/MainFrame/Control/VBoxContainer/ResultItem/idLine/identifierValue.text+"\"}\n"
	return text

func change_recipe_type(id) -> void:
	recipe_type = id
	match id:
		0:
			$Interface/VBoxContainer/MainFrame/Control/VBoxContainer/basinContents.visible = false
			$Interface/VBoxContainer/MainFrame/Control/VBoxContainer/pressing.visible = true
		1:
			$Interface/VBoxContainer/MainFrame/Control/VBoxContainer/basinContents.visible = true
			$Interface/VBoxContainer/MainFrame/Control/VBoxContainer/pressing.visible = false

func showRecipeWindow(text:String)-> void:
	var recipeTextSceneNew = recipeTextScene.instance()
	recipeTextSceneNew.recipe = text
	recipeTextSceneNew.Dir = dir
	get_tree().get_current_scene().add_child(recipeTextSceneNew)
