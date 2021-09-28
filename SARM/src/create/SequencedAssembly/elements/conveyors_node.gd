extends Spatial

var conveyors

func ChangeModels(key:Array):
	$Camera.translation.z = key.size()*0.5 - 0.5
	$SpotLight.translation.z = key.size()*0.5 - 0.5
	conveyors  = [false, false, false, false, false, false, false, false, false, false]
	for i in range(8): #conveyor reset
		get_node("conveyors/BeltState" + str(i)).visible = false
	for i in range(key.size()): 
		if key[i] == 0:
			get_node("conveyors/BeltState" + str(i)).visible = true
			get_node("conveyors/BeltState" + str(i)).machine_state = 1
			conveyors[i + 1] = true
		if key[i] == 1:
			get_node("conveyors/BeltState" + str(i)).visible = true
			get_node("conveyors/BeltState" + str(i)).belt_state = 4
			get_node("conveyors/BeltState" + str(i)).machine_state = 0
			conveyors[i + 1] = false
		elif key[i] == 2:
			get_node("conveyors/BeltState" + str(i)).visible = true
			get_node("conveyors/BeltState" + str(i)).machine_state = 2
			conveyors[i + 1] = true
		elif key[i] == 3:
			get_node("conveyors/BeltState" + str(i)).visible = true
			get_node("conveyors/BeltState" + str(i)).machine_state = 3
			conveyors[i + 1] = true
	print(conveyors)
	for i in range(1, 9): #Conveyor texture changer
		match conveyors[i]:
			true:
				match conveyors[i-1]:
					true:
						match conveyors[i+1]:
							true:
								get_node("conveyors/BeltState" + str(i - 1)).belt_state = 1
							false:
								get_node("conveyors/BeltState" + str(i - 1)).belt_state = 2
					false:
						match conveyors[i+1]:
							true:
								get_node("conveyors/BeltState" + str(i - 1)).belt_state = 0
							false:
								get_node("conveyors/BeltState" + str(i - 1)).belt_state = 3
			false:
				pass
	for i in range(8):
		get_node("conveyors/BeltState" + str(i)).update()

