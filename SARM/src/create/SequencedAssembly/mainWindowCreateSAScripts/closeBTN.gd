extends TextureButton

export var closeMode = int(0)

export(PackedScene) var closePopUp

func closePopUp() -> void:
	var closePopUpWindow = closePopUp.instance()
	closePopUpWindow.mode = closeMode
	get_tree().get_current_scene().add_child(closePopUpWindow)
