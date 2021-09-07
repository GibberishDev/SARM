extends Node2D
var SequenceTypes = [1, 1, 2, 0, 3, 0, 0, 1] #0 - deployer recipe, 1 - press recipe, 2 - spout recipe, 3 - sawing recipe
var ConveyorState = [false, false, false, false, false, false, false, false, false, false]

func _ready():
	updateSequenceSprites()

func updateSequenceSprites():
	for i in SequenceTypes.size():
		match SequenceTypes[i]:
			0:
				ConveyorState[i+1] = true
			1:
				ConveyorState[i+1] = true
			2:
				ConveyorState[i+1] = true
			3:
				ConveyorState[i+1] = false
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
	
	for i in range(1,9): #
		pass
	

func genSequenceText():
	pass
