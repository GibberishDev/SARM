extends Tree

export(PackedScene) var file
export(PackedScene) var foulder

var TESTDICTIONARY = {
	"root":
		{
			"test1":
				{
					"a":".txt",
					"b":".txt"
				},
			"test2":
				{
					"a":".txt",
					"b":".txt",
					"test3":
						{
							"a":".txt",
							"b":".txt"
						}
				}
		},
	"":""
}
var root = TreeItem
var id = int()

func make_root(name: String) -> void:
	root = create_item()
	root.set_text(0, name)

func get_content():
	pass

func make_tree(parent: String, dict: Dictionary) -> void:
	root = create_item()
	for i in dict.keys():
		var a = create_item(root)
		a.set_text(0, i)

func _ready():
	make_tree("a", TESTDICTIONARY)
