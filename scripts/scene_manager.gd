extends Node2D
var player : Player
var path = "res://scenes/"

func change_scene(from, to: String) -> void:
		player = from.player
		player.get_parent().remove_child(player)
		var full_path = path + to + ".tscn"
		get_tree().call_deferred("change_scene_to_file", (full_path))
	
