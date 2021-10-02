extends Control

var sequenceText = ["", "", "", "", "", "", "", ""]

var pathToButtons = "HBoxContainer/visualizerContainerOptions/ScrollContainer/Control/VBoxContainer/"
var viewport = "Control/bgOverlay/MainFrame/HBC/VBoxContainer/mainMenu/SequenceParams/VBoxContainer/SequenceVisualizer/Node2D/HBoxContainer/visualizerContainer/ViewportContainer"
var pathToSeqButton = "/HBoxContainer/Control/sequenceBtn"
var pathToControls = "/HBoxContainer/Control/HBoxContainer"

var SequenceTypes = [0, -1, -1, -1, -1, -1] #0 - press recipe, 1 - saw recipe, 2 - spout recipe, 3 - deployer recipe, -1 - null

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

func recieveMachineData(machineId: int, type: int, data: Dictionary):
	SMD[str(machineId)].type = type
	SMD[str(machineId)].data = data

func addMAchineEditorWindow(machineId: int):
	var new_machine_window = MachineWindow.instance()
	add_child(new_machine_window)
	match SMD[str(machineId)].type:
		0:
			new_machine_window.recipe_type = 0
			new_machine_window.machine_number = machineId
			new_machine_window.saw_processing_time = 200
			new_machine_window.spout_fluid_identifier = ":"
			new_machine_window.spout_fluid_amount = 250
			new_machine_window.deployer_addition_item = ""
			new_machine_window.deployer_addition_item_default = ":"
			new_machine_window.changeRecipeEditor(0, 20, ":", 250, ":")

func _ready():
	updateSequenceSprites()
	var ThisNode = self
	

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
	SMD["2"].active = !SMD["2"].active
	updateSequenceSprites()
func toggleBtn_3() -> void:
	get_node(pathToButtons + str(3) + pathToSeqButton).visible = !get_node(pathToButtons + str(3) + pathToSeqButton).visible
	get_node(pathToButtons + str(3) + pathToControls).visible = !get_node(pathToButtons + str(3) + pathToControls).visible
	get_node(pathToButtons + str(4) + pathToControls).visible = !get_node(pathToButtons + str(4) + pathToControls).visible
	SMD["3"].active = !SMD["3"].active
	updateSequenceSprites()
func toggleBtn_4() -> void:
	get_node(pathToButtons + str(4) + pathToSeqButton).visible = !get_node(pathToButtons + str(4) + pathToSeqButton).visible
	get_node(pathToButtons + str(4) + pathToControls).visible = !get_node(pathToButtons + str(4) + pathToControls).visible
	get_node(pathToButtons + str(5) + pathToControls).visible = !get_node(pathToButtons + str(5) + pathToControls).visible
	SMD["4"].active = !SMD["4"].active
	updateSequenceSprites()
func toggleBtn_5() -> void:
	get_node(pathToButtons + str(5) + pathToSeqButton).visible = !get_node(pathToButtons + str(5) + pathToSeqButton).visible
	get_node(pathToButtons + str(5) + pathToControls).visible = !get_node(pathToButtons + str(5) + pathToControls).visible
	get_node(pathToButtons + str(6) + pathToControls).visible = !get_node(pathToButtons + str(6) + pathToControls).visible
	SMD["5"].active = !SMD["5"].active
	updateSequenceSprites()
func toggleBtn_6() -> void:
	get_node(pathToButtons + str(6) + pathToSeqButton).visible = !get_node(pathToButtons + str(6) + pathToSeqButton).visible
	get_node(pathToButtons + str(6) + pathToControls).visible = !get_node(pathToButtons + str(6) + pathToControls).visible
	get_node(pathToButtons + "removeBtn/HBoxContainer").visible = !get_node(pathToButtons + "removeBtn/HBoxContainer").visible
	SMD["6"].active = !SMD["6"].active
	updateSequenceSprites()

func sendSeq() -> void:
	pass

func updateSequenceDict(mID: int, mState: bool, mType: int, mData: Dictionary) -> void:
	print(mID, mState, mType, mData)
