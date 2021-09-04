extends Node

var recipe = ""

var startItem = "minecraft:stone"
var transitItem = "minecraft:stone"
var resultingItem = "minecraft:stone"
export var numberLoops = int(1)
export var recipeType = int(0)
var outputText = ""
var startText = ""
const createSAStartingText = "{\n  \"credit\": \"Made using SARM tool by GibberishDev\",\n  \"type\": \"create:sequenced_assembly\",\n"
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
	print(recipe)

func startingText():
	startText = ""
	if recipeType == 0:
		startText += createSAStartingText
		getStartingItemText()
		startText += "  \"ingridient\":{\"" + startingItemTagMode + "\":\"" + startItem +"\"},\n"
		startText += "  \"transitionalItem\":{" + str(transitItem) + "},\n"
		startText += "  \"sequence\":[\n"
#	elif recipeType == 1:
#		addToOutputText(createMCStartingText)
	return startText

func addSequenceText(one:String, two:String, three:String, four:String, five:String, six:String, seven:String, eight:String):
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
	seqText += "\n  ],\n"
	return seqText

func endingText(resultItem: String, loops: int):
	endingRecipeText = ""
	if recipeType == 0:
		endingRecipeText = "  \"results\":[\n    \"item\": \"" + str(resultItem) + "\"\n  ],\n  \"loops\": " + str(loops) + "\n}"
	return endingRecipeText

func addToOutputText(text:String) -> void:
	outputText += text

func getStartingItemText():
	if $Control/bgOverlay/Control2/HBoxContainer/mainContainer/mainMenu/startingItem/startingItemParams.tagMode == false:
		startingItemTagMode = "item"
	else:
		startingItemTagMode = "tag"
	startItem = $Control/bgOverlay/Control2/HBoxContainer/mainContainer/mainMenu/startingItem/startingItemParams.identifierKeyText + ":" + $Control/bgOverlay/Control2/HBoxContainer/mainContainer/mainMenu/startingItem/startingItemParams.identifierValueText
