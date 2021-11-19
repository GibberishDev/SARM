extends TextureButton
export var closeMode = int(0)
export(PackedScene) var closePopUpScene
func closePopUp() -> void:
	var closePopUpWindow = closePopUpScene.instance()
	closePopUpWindow.mode = closeMode
	get_tree().get_current_scene().add_child(closePopUpWindow)
