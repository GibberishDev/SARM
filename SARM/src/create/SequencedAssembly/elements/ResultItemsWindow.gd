extends Control

var ItemArray = []

signal Results(ItemArray)

var pathToText = "allignmentH/allignmentV/MainFrame/VBoxContainer/MainFrame/HBoxContainer/HBoxContainer/item"

func openTextFill(Id: int, textItem: String, textWeight: String, textCount: String):
	var ItemTextArray = textItem.split(":")
	get_node(pathToText + str(Id) + "/TextEdit").text = ItemTextArray[0]
	get_node(pathToText + str(Id) + "/TextEdit2").text = ItemTextArray[1]
	get_node(pathToText + str(Id) + "/TextEdit3").text = textWeight
	get_node(pathToText + str(Id) + "/TextEdit4").text = textCount
	

func ComposeArray():
	ItemArray.clear()
	for i in range(9):
		if get_node(pathToText + str(i) + "/TextEdit").text != "" and get_node(pathToText + str(i) + "/TextEdit2").text != "":
			var newDict = {"item":null, "chance":null, "count":1}
			newDict["item"] = get_node(pathToText + str(i) + "/TextEdit").text + ":" + get_node(pathToText + str(i) + "/TextEdit2").text
			if get_node(pathToText + str(i) + "/TextEdit3").text.find(".") > -1:
				newDict["chance"] = get_node(pathToText + str(i) + "/TextEdit3").text
			elif get_node(pathToText + str(i) + "/TextEdit3").text.find(".") == -1 and get_node(pathToText + str(i) + "/TextEdit3").text != "":
				newDict["chance"] = get_node(pathToText + str(i) + "/TextEdit3").text + ".0"
			else:
				newDict["chance"] = "1.0"
			ItemArray.append(newDict)
	emit_signal("Results", ItemArray)
	queue_free()
	

func Close():
	queue_free()

