
@icon("res://addons/quest_system/assets/quest_resource.svg")
extends Quest
class_name BaseQuestResource

signal step_updated(step: QuestStep)

@export var steps: Array[QuestStep]
var index = 0
var current_step


func start(_args: Dictionary = {}) -> void:
	current_step = steps[index]
	current_step.ready()
	current_step.updated.connect(_update_step.bind(current_step))
	started.emit()


func get_quest_step(index: int) -> QuestStep:
	if index > steps.size():
		printerr("Out of bound. Tried to get QuestStep with index %s in an array of size %s" % [index, steps.size()])
	return steps[index]


func complete_step(index: int) -> Error:
	if index > steps.size():
		printerr("Out of bound. Tried to complete QuestStep with index %s in an array of size %s" % [index, steps.size()])
		return ERR_DOES_NOT_EXIST
	steps[index].completed = true
	return OK


func complete(_args: Dictionary = {}) -> void:
	for step in steps:
		if not step.meets_condition(): break
	completed.emit()


func get_first_uncompleted_step() -> QuestStep:
	var uncompleted_steps := steps.filter(func(step): return step.completed == false)
	if uncompleted_steps.is_empty(): return null
	return uncompleted_steps[0]


func _update_step(step: QuestStep) -> void:
	if step.meets_condition():
		step.completed = true
		step_updated.emit(step)
		index += 1
		if index >= steps.size():
			QuestSystem.complete_quest(self)
			return
		current_step = steps[index]
		current_step.ready()
		current_step.updated.connect(_update_step.bind(current_step))


func serialize() -> Dictionary:
	var steps_data: Dictionary
	for step in steps:
		steps_data[steps.find(step)] = step.serialize()

	var quest_data: Dictionary = {
		"objective_completed": objective_completed,
		"steps": steps_data
	}
	return quest_data


func deserialize(data: Dictionary) -> void:
	if "steps" in data.keys():
		for step in data.steps:
			steps[step].deserialize(data.steps[step])
	data.erase("steps")
	for key in data.keys():
		set(key, data[key])
		
func update(_args: Dictionary = {}) -> void:
	for step in steps:
		if not step.completed:
			if step.meets_condition():
				step.completed = true
				step_updated.emit(step)
			break
	# Check if all steps are done
	if steps.all(func(s): return s.completed):
		objective_completed = true
		print("done")
