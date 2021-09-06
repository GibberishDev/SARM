extends ViewportContainer
func hoverIn():
	$Viewport/CSAMiniview.hoverIn()
func hoverOut():
	$Viewport/CSAMiniview.hoverOut()
func GoTo():
	get_tree().change_scene("res://src/create/SequencedAssembly/MainWindowCreateSA.tscn")
