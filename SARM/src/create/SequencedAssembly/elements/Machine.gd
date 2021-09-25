extends Control

var RecipeType = int()

func _ready():
	ChangeRecipeEditor(0)

func ChangeRecipeEditor(type: int) -> void:
	match type:
		0:
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/PressRecipe.visible = true
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SawRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe.visible = false
		1:
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/PressRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SawRecipe.visible = true
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe.visible = false
		2:
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/PressRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SawRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe.visible = true
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe.visible = false
		3:
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/PressRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SawRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/SpoutRecipe.visible = false
			$VBoxContainer/Control/Control/VBoxContainer/Control/VBoxContainer/VBoxContainer/DeployerRecipe.visible = true

func ChangeRecipeType(index: int):
	RecipeType = index
	ChangeRecipeEditor(index)
