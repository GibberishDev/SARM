extends Control

var ThisNode = Node

var sequenceText = ["", "", "", "", "", "", "", ""]

var pathToButtons = "HBoxContainer/visualizerContainerOptions/ScrollContainer/Control/VBoxContainer/"
var viewport = "Control/bgOverlay/MainFrame/HBC/VBoxContainer/mainMenu/SequenceParams/VBoxContainer/SequenceVisualizer/Node2D/HBoxContainer/visualizerContainer/ViewportContainer"
var pathToSeqButton = "/HBoxContainer/Control/sequenceBtn"
var pathToControls = "/HBoxContainer/Control/HBoxContainer"

var SequenceTypes = [0, -1, -1, -1, -1, -1] #0 - press recipe, 1 - saw recipe, 2 - spout recipe, 3 - deployer recipe, -1 - null

signal SendRecipes(recipeArray)

export(PackedScene) var MachineWindow

#SequenceMechsDictionary, type: 0 - press, 1 - saw, 2 - spout, 3 - deployer
var SMD = {
	"1": {"active": true, "type": 0, "data": null},
	"2": {"active": false, "type": 0, "data": null},
	"3": {"active": false, "type": 0, "data": null},
	"4": {"active": false, "type": 0, "data": null},
	"5": {"active": false, "type": 0, "data": null},
	"6": {"active": false, "type": 0, "data": null}
}

func recieveMachineData(machineId: int, type: int, data):
	SMD[str(machineId)].type = type
	SMD[str(machineId)].data = data
	updateSequenceSprites()

func recieveMachineText(machineId: int, text: String):
	sequenceText[machineId-1] = text
	emit_signal("SendRecipes", sequenceText)

func addMAchineEditorWindow(machineId: int):
	var new_machine_window = MachineWindow.instance()
	get_tree().get_current_scene().add_child(new_machine_window)
	new_machine_window.connect("MachineData", ThisNode, "recieveMachineData")
	new_machine_window.connect("RecipeText", ThisNode, "recieveMachineText")
	match SMD[str(machineId)].type:
		0:
			new_machine_window.machine_number = machineId
			new_machine_window.recipe_type = 0
			new_machine_window.changeRecipeEditor(0, 20, ":", 250, ":", "item")
		1:
			new_machine_window.machine_number = machineId
			
			new_machine_window.recipe_type = 1
			if SMD[str(machineId)].data == null:
				new_machine_window.changeRecipeEditor(1, 20, ":", 250, ":", "item")
			else:
				new_machine_window.saw_processing_time = SMD[str(machineId)].data
				new_machine_window.changeRecipeEditor(1, int(SMD[str(machineId)].data), ":", 250, ":", "item")
		2:
			new_machine_window.machine_number = machineId
			
			new_machine_window.recipe_type = 2
			if SMD[str(machineId)].data == null:
				new_machine_window.changeRecipeEditor(2, 20, ":", 250, ":", "item")
			else:
				new_machine_window.spout_fluid_identifier = SMD[str(machineId)].data[0]
				new_machine_window.spout_fluid_amount = SMD[str(machineId)].data[1]
				new_machine_window.changeRecipeEditor(2, 20, SMD[str(machineId)].data[0], int(SMD[str(machineId)].data[1]), ":", "item")
		3:
			new_machine_window.machine_number = machineId
			
			new_machine_window.recipe_type = 3
			if SMD[str(machineId)].data == null:
				new_machine_window.changeRecipeEditor(3, 20, ":", 250, ":", "item")
			else:
				new_machine_window.deployer_addition_item = SMD[str(machineId)].data[0]
				new_machine_window.changeRecipeEditor(3, 20, ":", 250, SMD[str(machineId)].data[0], SMD[str(machineId)].data[1])

func _ready():
	updateSequenceSprites()
	ThisNode = self
	connect("SendRecipes", get_tree().get_current_scene(), "recieveRecipeArray")
	sequenceText[0] = """		{
			"type": "create:pressing",
			"ingredients": [{\"item\": TRPH}],
			"results": [{\"item\": TRPH}]
		}"""
	emit_signal("SendRecipes", sequenceText)

func updateSequenceSprites() -> void:
	for i in range(1, 7):
		if SMD[str(i)].active == true:
			SequenceTypes[i-1] = SMD[str(i)].type
		else:
			SequenceTypes[i-1] = -1
	$HBoxContainer/visualizerContainer/ViewportContainer/Viewport/VisualisationNode.ChangeModels(SequenceTypes)

func _on_Control_resized():
	var max_size = rect_size
	$HBoxContainer/visualizerContainer/ViewportContainer.rect_position = Vector2(max_size.x * 0.025, max_size.y * 0.025)
	$HBoxContainer/visualizerContainer/ViewportContainer/Viewport.size = Vector2(0.7 * max_size.x, max_size.y * (1 - 0.025 * 2))

#add/remove machines
func toggleBtn_2() -> void:
	get_node(pathToButtons + str(2) + pathToSeqButton).visible = !get_node(pathToButtons + str(2) + pathToSeqButton).visible
	get_node(pathToButtons + str(2) + pathToControls).visible = !get_node(pathToButtons + str(2) + pathToControls).visible
	get_node(pathToButtons + str(3) + pathToControls).visible = !get_node(pathToButtons + str(3) + pathToControls).visible
	if get_node(pathToButtons + str(2) + pathToSeqButton).visible == true:
		sequenceText[1] = """		{
			"type": "create:pressing",
			"ingredients": [{\"item\": TRPH}],
			"results": [{\"item\": TRPH}]
		}"""
	else:
		sequenceText[1] = ""
	SMD["2"].active = !SMD["2"].active
	SMD["2"].type = 0
	SMD["2"].data = null
	emit_signal("SendRecipes", sequenceText)
	updateSequenceSprites()
func toggleBtn_3() -> void:
	get_node(pathToButtons + str(3) + pathToSeqButton).visible = !get_node(pathToButtons + str(3) + pathToSeqButton).visible
	get_node(pathToButtons + str(3) + pathToControls).visible = !get_node(pathToButtons + str(3) + pathToControls).visible
	get_node(pathToButtons + str(4) + pathToControls).visible = !get_node(pathToButtons + str(4) + pathToControls).visible
	if get_node(pathToButtons + str(3) + pathToSeqButton).visible == true:
		sequenceText[2] = """		{
			"type": "create:pressing",
			"ingredients": [{\"item\": TRPH}],
			"results": [{\"item\": TRPH}]
		}"""
	else:
		sequenceText[2] = ""
	SMD["3"].active = !SMD["3"].active
	SMD["2"].type = 0
	SMD["2"].data = null
	emit_signal("SendRecipes", sequenceText)
	updateSequenceSprites()
func toggleBtn_4() -> void:
	get_node(pathToButtons + str(4) + pathToSeqButton).visible = !get_node(pathToButtons + str(4) + pathToSeqButton).visible
	get_node(pathToButtons + str(4) + pathToControls).visible = !get_node(pathToButtons + str(4) + pathToControls).visible
	get_node(pathToButtons + str(5) + pathToControls).visible = !get_node(pathToButtons + str(5) + pathToControls).visible
	if get_node(pathToButtons + str(4) + pathToSeqButton).visible == true:
		sequenceText[3] = """		{
			"type": "create:pressing",
			"ingredients": [{\"item\": TRPH}],
			"results": [{\"item\": TRPH}]
		}"""
	else:
		sequenceText[3] = ""
	SMD["4"].active = !SMD["4"].active
	SMD["2"].type = 0
	SMD["2"].data = null
	emit_signal("SendRecipes", sequenceText)
	updateSequenceSprites()
func toggleBtn_5() -> void:
	get_node(pathToButtons + str(5) + pathToSeqButton).visible = !get_node(pathToButtons + str(5) + pathToSeqButton).visible
	get_node(pathToButtons + str(5) + pathToControls).visible = !get_node(pathToButtons + str(5) + pathToControls).visible
	get_node(pathToButtons + str(6) + pathToControls).visible = !get_node(pathToButtons + str(6) + pathToControls).visible
	if get_node(pathToButtons + str(5) + pathToSeqButton).visible == true:
		sequenceText[4] = """		{
			"type": "create:pressing",
			"ingredients": [{\"item\": TRPH}],
			"results": [{\"item\": TRPH}]
		}"""
	else:
		sequenceText[4] = ""
	SMD["5"].active = !SMD["5"].active
	SMD["2"].type = 0
	SMD["2"].data = null
	emit_signal("SendRecipes", sequenceText)
	updateSequenceSprites()
func toggleBtn_6() -> void:
	get_node(pathToButtons + str(6) + pathToSeqButton).visible = !get_node(pathToButtons + str(6) + pathToSeqButton).visible
	get_node(pathToButtons + str(6) + pathToControls).visible = !get_node(pathToButtons + str(6) + pathToControls).visible
	get_node(pathToButtons + "removeBtn/HBoxContainer").visible = !get_node(pathToButtons + "removeBtn/HBoxContainer").visible
	if get_node(pathToButtons + str(6) + pathToSeqButton).visible == true:
		sequenceText[5] = """		{
			"type": "create:pressing",
			"ingredients": [{\"item\": TRPH}],
			"results": [{\"item\": TRPH}]
		}"""
	else:
		sequenceText[5] = ""
	SMD["6"].active = !SMD["6"].active
	SMD["2"].type = 0
	SMD["2"].data = null
	emit_signal("SendRecipes", sequenceText)
	updateSequenceSprites()

func machineWindowOne():
	addMAchineEditorWindow(1)
func machineWindowTwo():
	addMAchineEditorWindow(2)
func machineWindowThree():
	addMAchineEditorWindow(3)
func machineWindowFour():
	addMAchineEditorWindow(4)
func machineWindowFive():
	addMAchineEditorWindow(5)
func machineWindowSix():
	addMAchineEditorWindow(6)
