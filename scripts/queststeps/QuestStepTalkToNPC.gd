class_name TalkStep extends QuestStep

@export var npc_dialogue_resource: DialogueResource

var talked := false

func ready() -> void:
	var dialogue_manager = Engine.get_singleton("DialogueManager")
	dialogue_manager.dialogue_ended.connect(_on_dialogue_finished, CONNECT_DEFERRED)

func _on_dialogue_finished(resource: DialogueResource) -> void:
	if resource == npc_dialogue_resource:
		talked = true
		emit_signal("updated") # This tells the QuestSystem to re-check this step
		
func meets_condition() -> bool:
	return talked
