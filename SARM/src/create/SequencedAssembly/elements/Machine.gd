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
signal MachineData(MachineNumber, recipeType, data)

var path_shortener = "VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/"

func changeRecipeEditor(type: int, SPT: int, SFI: String, SFA: int, DAI: String, DAIM: String) -> void:
	recipe_type = type
	match type:
		0:
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/mode_picker/OptionButton.selected = 0
			get_node(path_shortener + "PressRecipe").visible = true
			get_node(path_shortener + "SawRecipe").visible = false
			get_node(path_shortener + "SpoutRecipe").visible = false
			get_node(path_shortener + "DeployerRecipe").visible = false
		1:
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/mode_picker/OptionButton.selected = 1
			saw_processing_time = SPT
			get_node(path_shortener + "SawRecipe/VBoxContainer/Control/HBoxContainer/processingTime").text = str(SPT)
			get_node(path_shortener + "PressRecipe").visible = false
			get_node(path_shortener + "SawRecipe").visible = true
			get_node(path_shortener + "SpoutRecipe").visible = false
			get_node(path_shortener + "DeployerRecipe").visible = false
		2:
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/mode_picker/OptionButton.selected = 2
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
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/mode_picker/OptionButton.selected = 3
			deployer_addition_item = DAI
			var Deployer_data = DAI.split(":", true)
			if DAIM == "item":
				deployerModeSwitcher(false)
			if DAIM == "tag":
				deployerModeSwitcher(true)
			get_node(path_shortener + "DeployerRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/modid").text = Deployer_data[0]
			get_node(path_shortener + "DeployerRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/identifier").text = Deployer_data[1]
			get_node(path_shortener + "PressRecipe").visible = false
			get_node(path_shortener + "SawRecipe").visible = false
			get_node(path_shortener + "SpoutRecipe").visible = false
			get_node(path_shortener + "DeployerRecipe").visible = true

func changeRecipeType(index: int):
	recipe_type = index 
	if saw_processing_time == 0:
		saw_processing_time = saw_processing_time_default
	if spout_fluid_identifier == "":
		spout_fluid_identifier = spout_fluid_identifier_default
	if spout_fluid_amount == 0:
		spout_fluid_amount = spout_fluid_amount_default
	if deployer_addition_item == "":
		deployer_addition_item = deployer_addition_item_default
	changeRecipeEditor(index, saw_processing_time, spout_fluid_identifier, spout_fluid_amount, deployer_addition_item, "item")

func sendText():
	match recipe_type:
		0:
			makePressRecipe()
			emit_signal("MachineData", machine_number, 0, null)
		1:
			makeSawRecipe()
			emit_signal("MachineData", machine_number, 1, saw_processing_time)
		2:
			makeSpoutRecipe()
			emit_signal("MachineData", machine_number, 2, [spout_fluid_identifier.replace("\"", ""), spout_fluid_nbt, spout_fluid_amount])
		3:
			makeDeployerRecipe()
			emit_signal("MachineData", machine_number, 3, [deployer_addition_item.replace("\"", ""), deployer_item_mode])
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
	if $VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control3/HBoxContainer/TextEdit.text == "":
		spout_fluid_nbt = "{}"
	else:
		spout_fluid_nbt = $VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control3/HBoxContainer/TextEdit.text
	recipe_text = """		{
			"type": "create:filling",
			"ingredients": [
				{\"item\": TRPH},
				{
					"fluid": """ + spout_fluid_identifier + """,
					"nbt": """ + spout_fluid_nbt + """,
					"amount": """ + str(spout_fluid_amount) + """
				}
			],
			"results": [{\"item\": TRPH}]
		}"""

func makeDeployerRecipe():
	recipe_text = ""
	deployer_addition_item = "\"" + $VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/modid.text + ":" + $VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/identifier.text + "\""
	recipe_text = """		{
			"type": "create:deploying",
			"ingredients": [{\"item\": TRPH}, {""" + "\"" + deployer_item_mode + "\": " + deployer_addition_item + """}],
			"results": [{\"item\": TRPH}]
		}"""

func deployerModeSwitcher(state):
		if state == true:
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/tagModeChanger/modeSwithcer.pressed = true
			deployer_item_mode = "tag"
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/deployer_identifier_label.text = "[MODID]:[TAG]"
		else:
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/tagModeChanger/modeSwithcer.pressed = false
			deployer_item_mode = "item"
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control/HBoxContainer/deployer_identifier_label.text = "[MODID]:[IDENTIFIER]"

func loadDefaultNBT() -> void:
	$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe/VBoxContainer/Control/VBoxContainer/HBoxContainer/VBoxContainer/Control3/HBoxContainer/TextEdit.text = """{"Bottle": "REGULAR", "Potion": "[REPLACE WITH POTION ID]"}"""

