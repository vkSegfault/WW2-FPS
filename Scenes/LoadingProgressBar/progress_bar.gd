extends Node

var scene_path: String = "res://Scenes/Levels/SeptemberCampaign/september_campaign_level.tscn"
var loading_status: int
var progress: Array[float]

@onready var progress_bar: ProgressBar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	ResourceLoader.load_threaded_request(scene_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	loading_status = ResourceLoader.load_threaded_get_status(scene_path, progress)

	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			print("Scene loading...")
			progress_bar.value = progress[0] * 100 # Change the ProgressBar value
		ResourceLoader.THREAD_LOAD_LOADED:
			print("Scene loaded")
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene_path))
		ResourceLoader.THREAD_LOAD_FAILED:
			print("Error. Could not load Resource")
