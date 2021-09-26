extends Node

export(PackedScene) var recipeTextScene

var recipe = ""

#var testArray = [
#	{"item": "create:precission_mechanism", "chance": 120.0},
#	{"item": "create:golden_sheet", "chance": 8.0},
#	]

var startItem = ""
var transitItem = ""
var resultingItem = ""
export var numberLoops = int(1)
var outputText = ""
var startText = ""
const createSAStartingText = """{
	\"credit\": \"Made using SARM tool by GibberishDev\",
	\"type\": \"create:sequenced_assembly\",\n"""
var seqOne = ""
var seqTwo = ""
var seqThree = ""
var seqFour = ""
var seqFive = ""
var seqSix = ""
var seqSeven = ""
var seqEight = ""
var seqText = ""
var endingRecipeText = ""

var startingItemTagMode = "item"

onready var nodeInstance_SIP = get_node("Control/bgOverlay/MainFrame/HBC/VBoxContainer/mainMenu/startingItem/startingItemParams") #Staring item params node
onready var nodeInstance_TIP = get_node("Control/bgOverlay/MainFrame/HBC/VBoxContainer/mainMenu/TransitItem/TransitItemParams") #Transit item params node
onready var nodeInstance_LP = get_node("Control/bgOverlay/MainFrame/HBC/VBoxContainer/mainMenu/loopsParams") #Transit item params node

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
	startText += "	\"ingredient\": {\"" + startingItemTagMode + "\": \"" + startItem +"\"},\n"
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
	if nodeInstance_SIP.tagMode == false:
		startingItemTagMode = "item"
	else:
		startingItemTagMode = "tag"
	startItem = nodeInstance_SIP.identifierKeyText + ": " + nodeInstance_SIP.identifierValueText
func getTarnsitItemText		():
	transitItem = "\"" + nodeInstance_TIP.identifierKeyText + ": " + nodeInstance_TIP.identifierValueText + "\""

func getResultingItem		():
	pass

func endingText				(resultItem:String,loops:int):
	endingRecipeText = ""
	loops = int(nodeInstance_LP.loops)
	endingRecipeText = """	\"results\": [
		\"item\": \"""" + str(resultItem) + """\"
	],
	\"loops\": """ + str(loops) + """
}"""
	return endingRecipeText
func addToOutputText		(text:String)-> void:
	outputText += text
func showRecipeWindow		(text:String)-> void:
	var recipeTextSceneNew = recipeTextScene.instance()
	recipeTextSceneNew.recipe = text
	get_tree().get_current_scene().add_child(recipeTextSceneNew)

func openSequenceRecipeEditor():
	$Control/Machine.TransitionalItem = transitItem
