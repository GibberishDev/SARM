extends Control

var sequenceText = ["", "", "", "", "", "", "", ""]

var pathToButtons = "HBoxContainer/visualizerContainerOptions/ScrollContainer/Control/VBoxContainer/"
var viewport = "Control/bgOverlay/MainFrame/HBC/VBoxContainer/mainMenu/SequenceParams/VBoxContainer/SequenceVisualizer/Node2D/HBoxContainer/visualizerContainer/ViewportContainer"
var pathToSeqButton = "/HBoxContainer/Control/sequenceBtn"
var pathToControls = "/HBoxContainer/Control/HBoxContainer"

var pressSequenceTemplate = """
		{
			\"type\":\"create:pressing\",
			\"ingredients\":[{TIR}],
			\"results\":[{TIR}]
		}"""
var sawSequenceTemplate = """
		{
			\"type\":\"create:cutting\",
			\"ingredients\":[{TIR}],
			\"results\":[{TIR}],
			\"processingTime\": TIME
		}"""
var spoutSequenceTemplate = """
		{
			\"type\":\"create:filling\",
			\"ingredients\":[{TIR},{\"fluid\":\"FLUID\",\"amount\":AMOUNT}],
			\"results\":[{TIR}],
		}"""

var SequenceTypes = [0, 1, 2, 3, 0, 1, 2, 3] #0 - press recipe, 1 - saw recipe, 2 - spout recipe, 3 - deployer recipe

func _ready():
	updateSequenceSprites()

func updateSequenceSprites():
	$HBoxContainer/visualizerContainer/ViewportContainer/Viewport/VisualisationNode.ChangeModels(SequenceTypes)

	genSequenceText()
	print(sequenceText)


func genSequenceText():
	for i in range(8):
		sequenceText[i] = ""
	for i in SequenceTypes.size():
		match SequenceTypes[i]:
			0:
				sequenceText[i] = pressSequenceTemplate
			1:
				sequenceText[i] = sawSequenceTemplate
			2:
				sequenceText[i] = spoutSequenceTemplate
			3:
				sequenceText[i] = sawSequenceTemplate

func _on_Control_resized():
	var max_size = rect_size
	var pref_size_x = 0.7 * max_size.x
	$HBoxContainer/visualizerContainer/ViewportContainer.rect_position = Vector2(max_size.x * 0.025, max_size.y * 0.025)
	$HBoxContainer/visualizerContainer/ViewportContainer/Viewport.size = Vector2(0.7 * max_size.x, max_size.y * (1 - 0.025 * 2))

func toggleBtn_2():
	get_node(pathToButtons + str(2) + pathToSeqButton).visible = !get_node(pathToButtons + str(2) + pathToSeqButton).visible
	get_node(pathToButtons + str(2) + pathToControls).visible = !get_node(pathToButtons + str(2) + pathToControls).visible
	get_node(pathToButtons + str(3) + pathToControls).visible = !get_node(pathToButtons + str(3) + pathToControls).visible
func toggleBtn_3():
	get_node(pathToButtons + str(3) + pathToSeqButton).visible = !get_node(pathToButtons + str(3) + pathToSeqButton).visible
	get_node(pathToButtons + str(3) + pathToControls).visible = !get_node(pathToButtons + str(3) + pathToControls).visible
	get_node(pathToButtons + str(4) + pathToControls).visible = !get_node(pathToButtons + str(4) + pathToControls).visible
func toggleBtn_4():
	get_node(pathToButtons + str(4) + pathToSeqButton).visible = !get_node(pathToButtons + str(4) + pathToSeqButton).visible
	get_node(pathToButtons + str(4) + pathToControls).visible = !get_node(pathToButtons + str(4) + pathToControls).visible
	get_node(pathToButtons + str(5) + pathToControls).visible = !get_node(pathToButtons + str(5) + pathToControls).visible
func toggleBtn_5():
	get_node(pathToButtons + str(5) + pathToSeqButton).visible = !get_node(pathToButtons + str(5) + pathToSeqButton).visible
	get_node(pathToButtons + str(5) + pathToControls).visible = !get_node(pathToButtons + str(5) + pathToControls).visible
	get_node(pathToButtons + str(6) + pathToControls).visible = !get_node(pathToButtons + str(6) + pathToControls).visible
func toggleBtn_6():
	get_node(pathToButtons + str(6) + pathToSeqButton).visible = !get_node(pathToButtons + str(6) + pathToSeqButton).visible
	get_node(pathToButtons + str(6) + pathToControls).visible = !get_node(pathToButtons + str(6) + pathToControls).visible
	get_node(pathToButtons + str(7) + pathToControls).visible = !get_node(pathToButtons + str(7) + pathToControls).visible
func toggleBtn_7():
	get_node(pathToButtons + str(7) + pathToSeqButton).visible = !get_node(pathToButtons + str(7) + pathToSeqButton).visible
	get_node(pathToButtons + str(7) + pathToControls).visible = !get_node(pathToButtons + str(7) + pathToControls).visible
	get_node(pathToButtons + str(8) + pathToControls).visible = !get_node(pathToButtons + str(8) + pathToControls).visible
func toggleBtn_8():
	get_node(pathToButtons + str(8) + pathToSeqButton).visible = !get_node(pathToButtons + str(8) + pathToSeqButton).visible
	get_node(pathToButtons + str(8) + pathToControls).visible = !get_node(pathToButtons + str(8) + pathToControls).visible
	get_node(pathToButtons + "removeBtn/HBoxContainer").visible = !get_node(pathToButtons + "removeBtn/HBoxContainer").visible
