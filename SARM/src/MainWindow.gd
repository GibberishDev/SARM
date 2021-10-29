extends Node

func show_recipes() -> void:
	$AnimationPlayer.play("slideIn")

func hide_recipes() -> void:
	$AnimationPlayer.play_backwards("slideIn")

#func get_filelist(scan_dir : String) -> Dictionary:
#	var my_dict : Dictionary = {}
#	var my_files : Array = []
#	var dir := Directory.new()
#	dir.open(scan_dir)
#	dir.list_dir_begin(true, true)
#	var file_name := dir.get_next()
#	while file_name != "":
#		my_files.append(file_name)
#		file_name = dir.get_next()
#	my_dict[scan_dir] = my_files
#	return my_dict



