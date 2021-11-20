extends ViewportContainer
func hoverIn():
	$Viewport/PressMiniview.hoverIn()
func hoverOut():
	$Viewport/PressMiniview.hoverOut()
func GoTo():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/create/Press/MainWindowCreateP.tscn")
