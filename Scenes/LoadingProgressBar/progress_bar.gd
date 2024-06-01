##################
#### Autoload ####
##################

extends Node

signal progress_changed(progress)
signal load_done

var _load_screen_path: String = "res://Scenes/LoadingProgressBar/loading_progress_bar.tscn"
var _load_screen = load(_load_screen_path)
var _loaded_resource: PackedScene
var _scene_path: String
var loading_status: int
var progress: Array[float] = []
var use_sub_threads: bool = true

@onready var progress_bar: ProgressBar = $ProgressBar


func load_scene(scene_path: String) -> void:
	_scene_path = scene_path
	
	var load_screen_instance = _load_screen.instantiate()
	get_tree().get_root().add_child(load_screen_instance)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#ResourceLoader.load_threaded_request(scene_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#loading_status = ResourceLoader.load_threaded_get_status(scene_path, progress)

	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			print("Scene loading...")
			progress_bar.value = progress[0] * 100 # Change the ProgressBar value
		ResourceLoader.THREAD_LOAD_LOADED:
			print("Scene loaded")
			#get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene_path))
		ResourceLoader.THREAD_LOAD_FAILED:
			print("Error. Could not load Resource")
