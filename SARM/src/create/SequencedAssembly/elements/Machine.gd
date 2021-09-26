extends Control

var recipe_type = int()
var recipe_text = ""

var machine_number = int()

var TransitionalItem = "\"test:tiph\"" #tiph aka transitional item placeholder

#custom variables
#saw
var saw_processing_time = int()
#spout
var spout_fluid_identifier = ""
var spout_fluid_nbt = "{}"
var spout_fluid_amount = int()
#deployer
var deployer_addition_item = "\"item\": \"test:aiph\"" #aiph aka addition item placeholder

signal RecipeText(MachineNumber, RecipeType, Text)

func _ready():
	changeRecipeEditor(0)

func changeRecipeEditor(type: int) -> void:
	match type:
		0:
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/PressRecipe.visible = true
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SawRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe.visible = false
		1:
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/PressRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SawRecipe.visible = true
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe.visible = false
		2:
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/PressRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SawRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe.visible = true
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe.visible = false
		3:
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/PressRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SawRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe.visible = true

func changeRecipeType(index: int):
	recipe_type = index
	changeRecipeEditor(index)
	saw_processing_time = 20
	$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SawRecipe/VBoxContainer/Control/HBoxContainer/TextEdit.text = "20"
	spout_fluid_identifier = ""
	spout_fluid_amount = 1000
	$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/modid.text = ""
	$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/identifier.text = ""
	$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control2/HBoxContainer/TextEdit.text = "1000"
	deployer_addition_item = ""
	$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/modid.text = ""
	$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/identifier.text = ""

func sendText():
	match recipe_type:
		0:
			makePressRecipe()
		1:
			makeSawRecipe()
		2:
			makeSpoutRecipe()
		3:
			pass
	emit_signal("RecipeText", machine_number, recipe_type, recipe_text)

func makePressRecipe():
	recipe_text = ""
	recipe_text = """		{
			"type": "create:pressing",
			"ingredients": [{\"item\": """ + TransitionalItem + """}],
			"results": [{\"item\": """ + TransitionalItem + """}]
		}"""

func makeSawRecipe():
	recipe_text = ""
	recipe_text = """		{
			"type": "create:cutting",
			"ingredients": [{\"item\": """ + TransitionalItem + """}],
			"results": [{\"item\": """ + TransitionalItem + """}],
			"processingTime": """ + str(saw_processing_time) + """
		}"""

func makeSpoutRecipe():
	recipe_text = ""
	recipe_text = """		{
			"type": "create:filling",
			"ingredients": [
				{\"item\": """ + TransitionalItem + """},
				{"fluid": """ + spout_fluid_identifier + """, "nbt": """ + spout_fluid_nbt + """, "amount": """ + str(spout_fluid_amount) + """}],
			"results": [{\"item\": """ + TransitionalItem + """}]
		}"""

func makeDeployerRecipe():
	recipe_text = ""
	recipe_text = """		{
			"type": "create:deploying",
			"ingredients": [{\"item\": """ + TransitionalItem + """}, {""" + deployer_addition_item + """}],
			"results": [{\"item\": """ + TransitionalItem + """}]
		}"""

