extends Spatial

var conveyors

export var setting_animations = bool(true)

var zCenter = float(0.0)
var SpotlightWaveUp = bool()

func ChangeModels(key:Array):
	zCenter = (6 - key.count(-1)) * 0.5 - 0.5
	conveyors  = [false, false, false, false, false, false, false, false]
	for i in range(6): 
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
		elif key[i] == -1:
			get_node("conveyors/BeltState" + str(i)).visible = false
	$Camera.translation = Vector3(-3, 2.5, zCenter + 0.5)
	for i in range(1, 7): #Conveyor texture changer
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
	for i in range(6):
		get_node("conveyors/BeltState" + str(i)).update("")
