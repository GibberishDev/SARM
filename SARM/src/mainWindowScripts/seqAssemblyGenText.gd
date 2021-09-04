extends Node

export(PackedScene) var recipeTextScene

var recipe = ""

var startItem = ""
var transitItem = ""
var resultingItem = ""
export var numberLoops = int(1)
var outputText = ""
var startText = ""
const createSAStartingText = "{\n	\"credit\": \"Made using SARM tool by GibberishDev\",\n	\"type\": \"create:sequenced_assembly\",\n"
var seqOne = "		{Sequence One}"
var seqTwo = "		{Sequence Two}"
var seqThree = "		{Etc.}"
var seqFour = ""
var seqFive = ""
var seqSix = ""
var seqSeven = ""
var seqEight = ""
var seqText = ""
var endingRecipeText = ""

var startingItemTagMode = "item"

func genText():
	var bufferText = ""
	bufferText = startingText()
	addToOutputText(bufferText)
	bufferText = addSequenceText(seqOne, seqTwo, seqThree, seqFour, seqFive, seqSix, seqSeven, seqEight)
	addToOutputText(bufferText)
	bufferText = endingText(resultingItem, numberLoops)
	addToOutputText(bufferText)
	bufferText = ""
	recipe = outputText
	outputText = ""
	showRecipeWindow(recipe)

func startingText			():
	startText = ""
	startText += createSAStartingText
	getStartingItemText()
	startText += "	\"ingridient\": {\"" + startingItemTagMode + "\": \"" + startItem +"\"},\n"
	getTarnsitItemText()
	startText += "	\"transitionalItem\": {" + str(transitItem) + "},\n"
	startText += "	\"sequence\": [\n"
	return startText
func addSequenceText		(one:String, two:String, three:String, four:String, five:String, six:String, seven:String, eight:String):
	seqText = ""
	if one != "":
		seqText += one
	if two != "":
		seqText += ",\n"
		seqText += two
	if three != "":
		seqText += ",\n"
		seqText += three
	if four != "":
		seqText += ",\n"
		seqText += four
	if five != "":
		seqText += ",\n"
		seqText += five
	if six != "":
		seqText += ",\n"
		seqText += six
	if seven != "":
		seqText += ",\n"
		seqText += seven
	if eight != "":
		seqText += ",\n"
		seqText += eight
	seqText += "\n	],\n"
	return seqText
func getStartingItemText	():
	if $Control/bgOverlay/Control2/HBoxContainer/mainContainer/HBoxContainer/VBoxContainer/mainMenu/startingItem/startingItemParams.tagMode == false:
		startingItemTagMode = "item"
	else:
		startingItemTagMode = "tag"
	startItem = $Control/bgOverlay/Control2/HBoxContainer/mainContainer/HBoxContainer/VBoxContainer/mainMenu/startingItem/startingItemParams.identifierKeyText + ": " + $Control/bgOverlay/Control2/HBoxContainer/mainContainer/HBoxContainer/VBoxContainer/mainMenu/startingItem/startingItemParams.identifierValueText

func getTarnsitItemText		():
	transitItem = "\"" + $Control/bgOverlay/Control2/HBoxContainer/mainContainer/HBoxContainer/VBoxContainer/mainMenu/TransitItem/TransitItemParams.identifierKeyText + ": " + $Control/bgOverlay/Control2/HBoxContainer/mainContainer/HBoxContainer/VBoxContainer/mainMenu/TransitItem/TransitItemParams.identifierValueText + "\""

func getResultingItem		():
	pass

func endingText				(resultItem:String,loops:int):
	endingRecipeText = ""
	loops = int($Control/bgOverlay/Control2/HBoxContainer/mainContainer/HBoxContainer/VBoxContainer/mainMenu/loopsParams.loops)
	endingRecipeText = "	\"results\": [\n		\"item\": \"" + str(resultItem) + "\"\n	],\n	\"loops\": " + str(loops) + "\n}"
	return endingRecipeText
func addToOutputText		(text:String)-> void:
	outputText += text
func showRecipeWindow		(text:String)-> void:
	var recipeTextSceneNew = recipeTextScene.instance()
	recipeTextSceneNew.recipe = text
	get_tree().get_current_scene().add_child(recipeTextSceneNew)


