extends Control

var recipe_type = int()
var recipe_text = ""

var machine_number = int()

#custom variables
#saw
var saw_processing_time = int()
var saw_processing_time_default = 20
#spout
var spout_fluid_identifier = ""
var spout_fluid_identifier_default = ":"
var spout_fluid_nbt = "{}"
var spout_fluid_amount = int()
var spout_fluid_amount_default = int(250)
#deployer
var deployer_item_mode = "item"
var deployer_addition_item = ""
var deployer_addition_item_default = ":"

signal RecipeText(MachineNumber, Text)
signal MachineData(MachineNumber, data)

var path_shortener = "VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/"

func changeRecipeEditor(type: int, SPT: int, SFI: String, SFA: int, DAI: String) -> void:
	match type:
		0:
			get_node(path_shortener + "PressRecipe").visible = true
			get_node(path_shortener + "SawRecipe").visible = false
			get_node(path_shortener + "SpoutRecipe").visible = false
			get_node(path_shortener + "DeployerRecipe").visible = false
		1:
			saw_processing_time = SPT
			get_node(path_shortener + "SawRecipe/VBoxContainer/Control/HBoxContainer/processingTime").text = str(SPT)
			get_node(path_shortener + "PressRecipe").visible = false
			get_node(path_shortener + "SawRecipe").visible = true
			get_node(path_shortener + "SpoutRecipe").visible = false
			get_node(path_shortener + "DeployerRecipe").visible = false
		2:
			spout_fluid_identifier = SFI
			spout_fluid_amount = SFA
			var Spout_data = SFI.split(":", true, 1)
			get_node(path_shortener + "SpoutRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/modid").text = Spout_data[0]
			get_node(path_shortener + "SpoutRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/identifier").text = Spout_data[1]
			get_node(path_shortener + "SpoutRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control2/HBoxContainer/amount").text = str(SFA)
			get_node(path_shortener + "PressRecipe").visible = false
			get_node(path_shortener + "SawRecipe").visible = false
			get_node(path_shortener + "SpoutRecipe").visible = true
			get_node(path_shortener + "DeployerRecipe").visible = false
		3:
			deployer_addition_item = DAI
			var Deployer_data = DAI.split(":", true)
			get_node(path_shortener + "DeployerRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/modid").text = Deployer_data[0]
			get_node(path_shortener + "DeployerRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/identifier").text = Deployer_data[1]
			get_node(path_shortener + "PressRecipe").visible = false
			get_node(path_shortener + "SawRecipe").visible = false
			get_node(path_shortener + "SpoutRecipe").visible = false
			get_node(path_shortener + "DeployerRecipe").visible = true

func changeRecipeType(index: int):
	recipe_type = index
	changeRecipeEditor(index, saw_processing_time_default, spout_fluid_identifier_default, spout_fluid_amount_default, deployer_addition_item_default)

func sendText():
	match recipe_type:
		0:
			makePressRecipe()
			emit_signal("MachineData", machine_number, null)
		1:
			makeSawRecipe()
			emit_signal("MachineData", machine_number, saw_processing_time)
		2:
			makeSpoutRecipe()
			emit_signal("MachineData", machine_number, [spout_fluid_identifier, spout_fluid_amount])
		3:
			makeDeployerRecipe()
			emit_signal("MachineData", machine_number, deployer_addition_item)
	emit_signal("RecipeText", machine_number, recipe_text)
	queue_free()

func close():
	queue_free()

func makePressRecipe():
	recipe_text = ""
	recipe_text = """		{
			"type": "create:pressing",
			"ingredients": [{\"item\": TRPH}],
			"results": [{\"item\": TRPH}]
		}"""

func makeSawRecipe():
	recipe_text = ""
	saw_processing_time = $VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SawRecipe/VBoxContainer/Control/HBoxContainer/processingTime.text
	recipe_text = """		{
			"type": "create:cutting",
			"ingredients": [{\"item\": TRPH}],
			"results": [{\"item\": TRPH}],
			"processingTime": """ + saw_processing_time + """
		}"""

func makeSpoutRecipe():
	recipe_text = ""
	spout_fluid_identifier ="\"" + $VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/modid.text + ":" + $VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/identifier.text + "\""
	spout_fluid_amount = $VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control2/HBoxContainer/amount.text
	recipe_text = """		{
			"type": "create:filling",
			"ingredients": [
				{\"item\": TRPH},
				{"fluid": """ + spout_fluid_identifier + """, "nbt": """ + spout_fluid_nbt + """, "amount": """ + str(spout_fluid_amount) + """}],
			"results": [{\"item\": TRPH}]
		}"""

func makeDeployerRecipe():
	recipe_text = ""
	deployer_addition_item = "\"" + deployer_item_mode + "\": \"" + $VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/modid.text + ":" + $VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/identifier.text + "\""
	recipe_text = """		{
			"type": "create:deploying",
			"ingredients": [{\"item\": TRPH}, {""" + deployer_addition_item + """}],
			"results": [{\"item\": TRPH}]
		}"""

func deployerModeSwitcher(state):
		if state == true:
			deployer_item_mode = "tag"
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/deployer_identifier_label.text = "[MODID]:[TAG]"
		else:
			deployer_item_mode = "item"
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/deployer_identifier_label.text = "[MODID]:[IDENTIFIER]"
