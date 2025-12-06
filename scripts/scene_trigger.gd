extends Node
class_name SceneTrigger

@export var connected_scene: String #name of scene to change to 
var scene_folder = "res://scenes/"

func _on_body_entered(body):
	if body is Player:
		SceneManager.change_scene(get_owner(), connected_scene)
			
