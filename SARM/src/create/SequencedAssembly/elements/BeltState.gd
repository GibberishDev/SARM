tool
extends Spatial
export(int, "start", "middle", "end", "single", "saw") var belt_state 
export(int, "saw", "press", "spout", "deployer") var machine_state
export(bool) var update_editor_view setget update
export(Mesh) var belt_side
export(Mesh) var belt_middle
export(Mesh) var depot
export(Mesh) var saw
export(Mesh) var press
export(Mesh) var spout
export(Mesh) var deployer
func update(_dummy):
	match belt_state:
		0:
			$BeltPart.mesh = belt_side
			$BeltPart.rotation_degrees.y = 0
		1:
			$BeltPart.mesh = belt_middle
			$BeltPart.rotation_degrees.y = 0
		2:
			$BeltPart.mesh = belt_side
			$BeltPart.rotation_degrees.y = 180
		3:
			$BeltPart.mesh = depot
			$BeltPart.rotation_degrees.y = 0
		4:
			$BeltPart.mesh = saw
			$BeltPart.rotation_degrees.y = 90
	match machine_state:
		1:
			$MachinePart.visible = true
			$MachinePart.mesh = press
		2:
			$MachinePart.visible = true
			$MachinePart.mesh = spout
		3:
			$MachinePart.visible = true
			$MachinePart.mesh = deployer
		0:
			$MachinePart.visible = false
