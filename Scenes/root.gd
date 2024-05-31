extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	self.name = 'Root'
	
	# load menu as first scene after root
	var menu_scene = load("res://Scenes/Menu/menu.tscn")
	var menu_instance = menu_scene.instantiate()
	menu_instance.name = str("menu")
	self.add_child(menu_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
