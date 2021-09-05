extends TextureButton

export(PackedScene) var closePopUp

func closePopUp() -> void:
	var closePopUpWindow = closePopUp.instance()
	get_tree().get_current_scene().add_child(closePopUpWindow)
