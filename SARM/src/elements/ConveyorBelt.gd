extends Node2D
var beltData = [false, false, false, false, false, false, false, false, false, false]
func _ready():
	updateConveyors()
func updateConveyors():
	for i in range(1, 9):
		if beltData[i] == true:
			get_node("conveyorParts/" + str(i)).visible = true
			match beltData[i-1]:
				true:
					match beltData[i+1]:
						true:
							get_node("conveyorParts/" + str(i)).mode = 2
						false:
							get_node("conveyorParts/" + str(i)).mode = 3
				false:
					match beltData[i+1]:
						true:
							get_node("conveyorParts/" + str(i)).mode = 1
						false:
							get_node("conveyorParts/" + str(i)).mode = 0
		else:
			get_node("conveyorParts/" + str(i)).visible = false
