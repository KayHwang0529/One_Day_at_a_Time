extends Button
@onready var page = $"."
# Called when the node enters the scene tree for the first time.

func _on_pressed() -> void:
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/dialogue.dialogue"),"start_talk_to_dad")
	page.hide()
	return
