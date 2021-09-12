extends Node2D

var sequenceText = ["", "", "", "", "", "", "", ""]

var pathToButtons = "Control/bgOverlay/MainFrame/HBC/VBoxContainer/mainMenu/SequenceParams/VBoxContainer/SequenceVisualizer/Node2D/HBoxContainer/visualizerContainerOptions/ScrollContainer/Control/VBoxContainer/"
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

var SequenceTypes = [0, 0, 1, 1, 2, 2, 3, 3] #0 - press recipe, 1 - saw recipe, 2 - spout recipe, 3 - deployer recipe
var ConveyorState = [false, false, false, false, false, false, false, false, false, false]

func _ready():
	updateSequenceSprites()

func updateSequenceSprites():
	for i in range(1, 9):
		get_node("machines/" + str(i)).visible = false
	for i in SequenceTypes.size():
		get_node("machines/" + str(i+1)).visible = true
		match SequenceTypes[i]:
			0:
				ConveyorState[i+1] = true
				get_node("machines/" + str(i+1)).frame = 0
				get_node("machines/" + str(i+1)).position.y = -128
			1:
				ConveyorState[i+1] = false
				get_node("machines/" + str(i+1)).frame = 1
				get_node("machines/" + str(i+1)).position.y = 32
			2:
				ConveyorState[i+1] = true
				get_node("machines/" + str(i+1)).frame = 2
				get_node("machines/" + str(i+1)).position.y = -128
			3:
				ConveyorState[i+1] = true
				get_node("machines/" + str(i+1)).frame = 3
				get_node("machines/" + str(i+1)).position.y = -128
	for i in range(1,9): #update conveyor sprites
		match ConveyorState[i]:
			true:
				get_node("conveyorSprites/"+str(i)).visible = true
				match ConveyorState[i-1]:
					true:
						match ConveyorState[i+1]:
							true:
								get_node("conveyorSprites/"+str(i)).frame = 1
							false:
								get_node("conveyorSprites/"+str(i)).frame = 2
					false:
						match ConveyorState[i+1]:
							true:
								get_node("conveyorSprites/"+str(i)).frame = 0
							false:
								get_node("conveyorSprites/"+str(i)).frame = 3
			false:
				get_node("conveyorSprites/"+str(i)).visible = false
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
	var max_size_x = get_node("..").rect_size.x
	var max_size_y = get_node("..").rect_size.y
	var pref_size_x = 0.7 * max_size_x
	var scale_modifier =  pref_size_x / 1024
	scale = Vector2(scale_modifier, scale_modifier)
	position.x = max_size_x * 0.025
	position.y = max_size_y * 0.5

func toggleBtn_2():
	get_tree().get_current_scene().get_node(pathToButtons + str(2) + pathToSeqButton).visible = !get_tree().get_current_scene().get_node(pathToButtons + str(2) + pathToSeqButton).visible
	get_tree().get_current_scene().get_node(pathToButtons + str(2) + pathToControls).visible = !get_tree().get_current_scene().get_node(pathToButtons + str(2) + pathToControls).visible
	get_tree().get_current_scene().get_node(pathToButtons + str(3) + pathToControls).visible = !get_tree().get_current_scene().get_node(pathToButtons + str(3) + pathToControls).visible
func toggleBtn_3():
	get_tree().get_current_scene().get_node(pathToButtons + str(3) + pathToSeqButton).visible = !get_tree().get_current_scene().get_node(pathToButtons + str(3) + pathToSeqButton).visible
	get_tree().get_current_scene().get_node(pathToButtons + str(3) + pathToControls).visible = !get_tree().get_current_scene().get_node(pathToButtons + str(3) + pathToControls).visible
	get_tree().get_current_scene().get_node(pathToButtons + str(4) + pathToControls).visible = !get_tree().get_current_scene().get_node(pathToButtons + str(4) + pathToControls).visible
func toggleBtn_4():
	get_tree().get_current_scene().get_node(pathToButtons + str(4) + pathToSeqButton).visible = !get_tree().get_current_scene().get_node(pathToButtons + str(4) + pathToSeqButton).visible
	get_tree().get_current_scene().get_node(pathToButtons + str(4) + pathToControls).visible = !get_tree().get_current_scene().get_node(pathToButtons + str(4) + pathToControls).visible
	get_tree().get_current_scene().get_node(pathToButtons + str(5) + pathToControls).visible = !get_tree().get_current_scene().get_node(pathToButtons + str(5) + pathToControls).visible
func toggleBtn_5():
	get_tree().get_current_scene().get_node(pathToButtons + str(5) + pathToSeqButton).visible = !get_tree().get_current_scene().get_node(pathToButtons + str(5) + pathToSeqButton).visible
	get_tree().get_current_scene().get_node(pathToButtons + str(5) + pathToControls).visible = !get_tree().get_current_scene().get_node(pathToButtons + str(5) + pathToControls).visible
	get_tree().get_current_scene().get_node(pathToButtons + str(6) + pathToControls).visible = !get_tree().get_current_scene().get_node(pathToButtons + str(6) + pathToControls).visible
func toggleBtn_6():
	get_tree().get_current_scene().get_node(pathToButtons + str(6) + pathToSeqButton).visible = !get_tree().get_current_scene().get_node(pathToButtons + str(6) + pathToSeqButton).visible
	get_tree().get_current_scene().get_node(pathToButtons + str(6) + pathToControls).visible = !get_tree().get_current_scene().get_node(pathToButtons + str(6) + pathToControls).visible
	get_tree().get_current_scene().get_node(pathToButtons + str(7) + pathToControls).visible = !get_tree().get_current_scene().get_node(pathToButtons + str(7) + pathToControls).visible
func toggleBtn_7():
	get_tree().get_current_scene().get_node(pathToButtons + str(7) + pathToSeqButton).visible = !get_tree().get_current_scene().get_node(pathToButtons + str(7) + pathToSeqButton).visible
	get_tree().get_current_scene().get_node(pathToButtons + str(7) + pathToControls).visible = !get_tree().get_current_scene().get_node(pathToButtons + str(7) + pathToControls).visible
	get_tree().get_current_scene().get_node(pathToButtons + str(8) + pathToControls).visible = !get_tree().get_current_scene().get_node(pathToButtons + str(8) + pathToControls).visible
func toggleBtn_8():
	get_tree().get_current_scene().get_node(pathToButtons + str(8) + pathToSeqButton).visible = !get_tree().get_current_scene().get_node(pathToButtons + str(8) + pathToSeqButton).visible
	get_tree().get_current_scene().get_node(pathToButtons + str(8) + pathToControls).visible = !get_tree().get_current_scene().get_node(pathToButtons + str(8) + pathToControls).visible
	get_tree().get_current_scene().get_node(pathToButtons + "removeBtn/HBoxContainer").visible = !get_tree().get_current_scene().get_node(pathToButtons + "removeBtn/HBoxContainer").visible
