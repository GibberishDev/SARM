extends Control

export(PackedScene) var IngredientItemScene
export(PackedScene) var IngredientFluidScene

var number_of_items = int(0)
var number_of_fluids = int(0)
var heating = int(0) #0 - no heating, 1 - heated, 2 - superheated

func change_housing_size(id) -> void: #id 0 - added item, 1 - added fluid, 2 - removed item, 3 - removed fluid
	
	match id:
		0:
			$ScrollContainer/IngredientsHousing.rect_min_size.y += 84
		1:
			$ScrollContainer/IngredientsHousing.rect_min_size.y += 256
		2:
			$ScrollContainer/IngredientsHousing.rect_min_size.y -= 84
		3:
			$ScrollContainer/IngredientsHousing.rect_min_size.y -= 256

func add_item_ingredient() -> void:
	var new_item_instance = IngredientItemScene.instance()
	number_of_items += 1
	new_item_instance.name = str(number_of_items)
	$ScrollContainer/IngredientsHousing/VBoxContainer/ItemsHousing.rect_min_size.y += 84
	$ScrollContainer/IngredientsHousing/VBoxContainer/ItemsHousing.add_child(new_item_instance)
	change_housing_size(0)
	if number_of_items != 0:
		$ScrollContainer/IngredientsHousing/VBoxContainer/BtnItems/removeBtn/TextureButton2.disabled = false
	if number_of_items == 8:
		$ScrollContainer/IngredientsHousing/VBoxContainer/BtnItems/addBtn/TextureButton.disabled = true

func remove_item_ingredient() -> void:
	get_node("ScrollContainer/IngredientsHousing/VBoxContainer/ItemsHousing/" + str(number_of_items)).queue_free()
	number_of_items -= 1
	$ScrollContainer/IngredientsHousing/VBoxContainer/ItemsHousing.rect_min_size.y -= 84
	change_housing_size(2)
	if number_of_items == 0:
		$ScrollContainer/IngredientsHousing/VBoxContainer/BtnItems/removeBtn/TextureButton2.disabled = true
	if number_of_items != 8:
		$ScrollContainer/IngredientsHousing/VBoxContainer/BtnItems/addBtn/TextureButton.disabled = false
		
func add_fluid_ingredient() -> void:
	var new_fluid_instance = IngredientFluidScene.instance()
	number_of_fluids += 1
	new_fluid_instance.name = str(number_of_fluids)
	$ScrollContainer/IngredientsHousing/VBoxContainer/FluidsHousing.rect_min_size.y += 256
	$ScrollContainer/IngredientsHousing/VBoxContainer/FluidsHousing.add_child(new_fluid_instance)
	change_housing_size(1)
	if number_of_fluids != 0:
		$ScrollContainer/IngredientsHousing/VBoxContainer/BtnFluids/removeBtn/TextureButton2.disabled = false
	if number_of_fluids == 2:
		$ScrollContainer/IngredientsHousing/VBoxContainer/BtnFluids/addBtn/TextureButton.disabled = true

func remove_fluid_ingredient() -> void:
	get_node("ScrollContainer/IngredientsHousing/VBoxContainer/FluidsHousing/" + str(number_of_fluids)).queue_free()
	number_of_fluids -= 1
	$ScrollContainer/IngredientsHousing/VBoxContainer/FluidsHousing.rect_min_size.y -= 256
	change_housing_size(3)
	if number_of_fluids == 0:
		$ScrollContainer/IngredientsHousing/VBoxContainer/BtnFluids/removeBtn/TextureButton2.disabled = true
	if number_of_fluids != 2:
		$ScrollContainer/IngredientsHousing/VBoxContainer/BtnFluids/addBtn/TextureButton.disabled = false

func get_text() -> String:
	var recipe_text = """	"ingredients": [\n"""
	if number_of_items != 0:
		for i in range(1, number_of_items + 1):
			for z in range(get_node("ScrollContainer/IngredientsHousing/VBoxContainer/ItemsHousing/" + str(i)).get_amount()):
				recipe_text += get_node("ScrollContainer/IngredientsHousing/VBoxContainer/ItemsHousing/" + str(i)).get_ingredient_text()
				if number_of_fluids != 0 or number_of_items != 0:
					recipe_text += ",\n"
				else:
					recipe_text += "\n"
	if number_of_fluids != 0:
		for i in range(1, number_of_fluids + 1):
			recipe_text += get_node("ScrollContainer/IngredientsHousing/VBoxContainer/FluidsHousing/" + str(i)).get_ingredient_text()
			if i != number_of_fluids:
				recipe_text += ",\n"
			else:
				recipe_text += "\n"
	recipe_text += "	]"
	if heating == 1:
		recipe_text += """,\n 	"heatRequirement": "heated\""""
	elif heating == 2:
		recipe_text += """,\n 	"heatRequirement": "superheated\""""
	return recipe_text


func change_heating(id) -> void:
	heating = id
