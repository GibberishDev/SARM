extends Control
var recipe = ""
func _ready():
	$RecipeWindow.rect_size = Vector2(1024, 600) - Vector2(64, 64)
	$RecipeWindow.rect_position = Vector2(32, 32)
	$RecipeWindow/HBoxContainer2/RecipeBoundry/HBoxContainer/VBoxContainer/recipe.text = recipe
func close():
	queue_free()
