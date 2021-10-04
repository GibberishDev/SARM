extends Control

export(PackedScene) var warn
var fileDir = "E:/test/test.json"
var Text = "recipe"

func save():
	var file = File.new()
	file.open(fileDir, File.WRITE)
	file.store_string(Text)
	file.close()
	var newWarn = warn.instance()
	newWarn.mode = 7
	get_tree().get_current_scene().add_child(newWarn)
	queue_free()

func decline():
	queue_free()
