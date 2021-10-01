extends Control

var recipe_type = int()
var recipe_text = ""

var machine_number = int()

#custom variables
#saw
var saw_processing_time = int()
var saw_processing_time_default = int(20)
#spout
var spout_fluid_identifier = ""
var spout_fluid_identifier_default = ":"
var spout_fluid_nbt = "{}"
var spout_fluid_amount = int()
var spout_fluid_amount_default = int(250)
#deployer
var deployer_addition_item = ""
var deployer_addition_item_default = ":"

signal RecipeText(MachineNumber, Text)

func changeRecipeEditor(type: int, SPT: int, SFI: String, SFA: int, DAI: String) -> void:
	match type:
		0:
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/PressRecipe.visible = true
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SawRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe.visible = false
		1:
			saw_processing_time = SPT
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SawRecipe/VBoxContainer/Control/HBoxContainer/TextEdit.text = str(SPT)
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/PressRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SawRecipe.visible = true
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe.visible = false
		2:
			spout_fluid_identifier = SFI
			spout_fluid_amount = SFA
			var Spout_data = SFI.split(":", true, 1)
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/modid.text = Spout_data[0]
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/identifier.text = Spout_data[1]
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control2/HBoxContainer/TextEdit.text = str(SFA)
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/PressRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SawRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe.visible = true
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe.visible = false
		3:
			deployer_addition_item = DAI
			var Deployer_data = DAI.split(":", true, 1)
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/modid.text = Deployer_data[0]
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/identifier.text = Deployer_data[1]
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/PressRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SawRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe.visible = true

func changeRecipeType(index: int):
	recipe_type = index
	changeRecipeEditor(index, saw_processing_time_default, spout_fluid_identifier_default, spout_fluid_amount_default, deployer_addition_item_default)

func sendText():
	match recipe_type:
		0:
			makePressRecipe()
		1:
			makeSawRecipe()
		2:
			makeSpoutRecipe()
		3:
			makeDeployerRecipe()
	emit_signal("RecipeText", machine_number, recipe_text)

func makePressRecipe():
	recipe_text = ""
	recipe_text = """		{
			"type": "create:pressing",
			"ingredients": [{\"item\": TRPH}],
			"results": [{\"item\": TRPH}]
		}"""

func makeSawRecipe():
	recipe_text = ""
	recipe_text = """		{
			"type": "create:cutting",
			"ingredients": [{\"item\": TRPH}],
			"results": [{\"item\": TRPH}],
			"processingTime": """ + str(saw_processing_time) + """
		}"""

func makeSpoutRecipe():
	recipe_text = ""
	recipe_text = """		{
			"type": "create:filling",
			"ingredients": [
				{\"item\": TRPH},
				{"fluid": """ + spout_fluid_identifier + """, "nbt": """ + spout_fluid_nbt + """, "amount": """ + str(spout_fluid_amount) + """}],
			"results": [{\"item\": TRPH}]
		}"""

func makeDeployerRecipe():
	recipe_text = ""
	recipe_text = """		{
			"type": "create:deploying",
			"ingredients": [{\"item\": TRPH}, {""" + deployer_addition_item + """}],
			"results": [{\"item\": TRPH}]
		}"""


