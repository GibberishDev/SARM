extends Node2D

var sequenceText = ["", "", "", "", "", "", "", ""]

var pressSequenceTemplate = "		{\n			\"type\":\"create:pressing\",\n			\"ingredients\":[{TIR}],\n			\"results\":[{TIR}]\n		}"
var sawSequenceTemplate = "		{\n			\"type\":\"create:cutting\",\n			\"ingredients\":[{TIR}],\n			\"results\":[{TIR}],\n			\"processingTime\": TIME\n		}"
var spoutSequenceTemplate = "		{\n			\"type\":\"create:filling\",\n			\"ingredients\":[{TIR},{\"fluid\":\"FLUID\",\"amount\":AMOUNT}],\n			\"results\":[{TIR}],\n		}"

var SequenceTypes = [1, 1, 2, 0, 3, 0, 0, 1] #0 - press recipe, 1 - saw recipe, 2 - spout recipe, 3 - deployer recipe
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
				get_node("machines/" + str(i+1)).position.y = -160
			1:
				ConveyorState[i+1] = false
				get_node("machines/" + str(i+1)).frame = 1
				get_node("machines/" + str(i+1)).position.y = 0
			2:
				ConveyorState[i+1] = true
				get_node("machines/" + str(i+1)).frame = 2
				get_node("machines/" + str(i+1)).position.y = -160
			3:
				ConveyorState[i+1] = true
				get_node("machines/" + str(i+1)).frame = 3
				get_node("machines/" + str(i+1)).position.y = -160
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
