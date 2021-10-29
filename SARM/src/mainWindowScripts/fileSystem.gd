extends Tree

export(Texture) var FileIcon
export(Texture) var FoulderIcon

var TESTDIRECTORY = {
	"root":{"test1":{"a":".txt","b":".txt"},"test2":{"a":".txt","b":".txt","test3":{"a":".txt","b":".txt"}}}
}
var root = TreeItem
var id = int()

func make_root(name: String) -> void:
	root = create_item()
	root.set_text(0, name)


func make_tree(parent: String, file: String) -> void:
	id += 1
	var a = TreeItem
	

#func _ready():
#	var root = create_item()
#	root.set_text(0, " root")
#	var child1 = create_item(root)
#	child1.set_text(0, " test1")
#	child1.set_icon(0, FoulderIcon)
#	var child2 = create_item(root)
#	child2.set_text(0, " test2")
#	child2.set_icon(0, FoulderIcon)
#	var subchild1 = create_item(child1)
#	subchild1.set_text(0, " test3")
#	subchild1.set_icon(0, FileIcon)
