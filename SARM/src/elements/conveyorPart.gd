extends AnimatedSprite

export var mode = int(0) #0 - singular, 1 - left, 2 - middle, 3 - right

func _process(delta):
	textureSetChange()

func textureSetChange():
	match mode:
		0:
			animation = "singular"
		1:
			animation = "left"
		2:
			animation = "middle"
		3:
			animation = "right"
