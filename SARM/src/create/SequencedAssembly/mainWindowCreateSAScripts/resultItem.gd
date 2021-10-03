extends HBoxContainer

var items = []
var itemsDicts = []

export(PackedScene) var EditWindow

func openEditWindow():
	var window = EditWindow.instance()
	window.connect("Results", self, "recieveArray")
	if itemsDicts.size() != 0:
		for i in range(itemsDicts.size()):
			window.openTextFill(i, itemsDicts[i].item, itemsDicts[i].chance)
	get_tree().get_current_scene().add_child(window)
	

func recieveArray(arr: Array):
	itemsDicts = arr
	parseDicts()

func parseDicts():
	items = []
	for i in range(itemsDicts.size()):
		var item = ""
		item = "		{\"item\": \"" + itemsDicts[i].item + "\", \"chance\": " + itemsDicts[i].chance + "\"}"
		items.append(item)
