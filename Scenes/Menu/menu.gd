extends Node

const september_campaign_scene_path: String = "res://Scenes/Levels/SeptemberCampaign/september_campaign_level.tscn"

@onready var progress_bar = $Panel/ProgressBar
var loading_status: int
var progress: Array[float]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	loading_status = ResourceLoader.load_threaded_get_status("res://Scenes/Levels/SeptemberCampaign/september_campaign_level.tscn", progress)
	
	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			print("Scene loading...")
			progress_bar.value = progress[0] * 100 # Change the ProgressBar value
		ResourceLoader.THREAD_LOAD_LOADED:
			var scene: PackedScene = ResourceLoader.load_threaded_get(september_campaign_scene_path)
			var scene_instance = scene.instantiate()
			get_tree().get_root().get_node("Root/Levels").add_child(scene_instance)
			print("Scene loaded")
			$Panel.hide()
		ResourceLoader.THREAD_LOAD_FAILED:
			print("Error. Could not load Resource")


func _on_button_pressed():
	$Panel/Button.hide()
	
	# spawn loading screen first
	#spawn_scene("res://Scenes/LoadingProgressBar/loading_progress_bar.tscn", "loading_progress_bar")
	ResourceLoader.load_threaded_request("res://Scenes/Levels/SeptemberCampaign/september_campaign_level.tscn", "", true)
	#ResourceLoader.load_threaded_request("res://Scenes/Character/character_body_3d.tscn", "", true)
	
	# spawn character only when main level has been loaded
	if 
	spawn_scene("res://Scenes/Levels/SeptemberCampaign/september_campaign_level.tscn", "september_campaign", "Root/Levels")
	#spawn_scene("res://Scenes/Character/character_body_3d.tscn", "character", "Root/Levels")


func spawn_scene(scene_path: String, scene_name: String, spawn_location: String = "Root"):
	var level_scene = load(scene_path)
	var level_instance = level_scene.instantiate()
	level_instance.name = str(scene_name)
	
	# 3 ways to add instance to `root` node
	#self.get_parent().add_child(level_instance)
	#$".".add_child(level_instance)
	get_tree().get_root().get_node(spawn_location).add_child(level_instance)  # add child under spawn location


func despawn_scene(scene_instance):
	scene_instance.queue_free()
