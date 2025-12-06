extends CanvasLayer

var _quest: Quest
var current_step_index: int = 0

@onready var currentQuest_label = $Panel/VBoxContainer/currentQuest
@onready var step_title_label = $Panel/VBoxContainer/StepTitle

func _ready() -> void:
	# Connect to signals for quest updates
	QuestSystem.quest_accepted.connect(set_current_quest)
	QuestSystem.quest_completed.connect(finish_quest)

	# Initially hide the UI elements
	currentQuest_label.hide()
	step_title_label.hide()


func _process(_delta: float) -> void:
	if _quest == null:
		currentQuest_label.hide()
		step_title_label.hide()

		return
	else:
		# Display the current quest name
		currentQuest_label.text = "Current Quest: %s" % _quest.quest_name

		# Show the current quest step
		if _quest.steps.size() > 0:
			_show_current_step()

func _show_current_step() -> void:
	if current_step_index < _quest.steps.size():
		var step = _quest.steps[current_step_index]
		step_title_label.text = "Step: %s" % step.title

		# Make the step UI visible
		step_title_label.show()


		# If this step is complete, move to the next step
		if step.completed:
			current_step_index += 1
			if current_step_index >= _quest.steps.size():
				QuestSystem.complete_quest(_quest)
		else:
			# Handle any step-specific logic here, e.g., updating the step progress
			pass
	else:
		# If no more steps, hide step UI
		step_title_label.hide()


func set_current_quest(quest: Quest) -> void:
	_quest = quest
	currentQuest_label.show()

	# Reset step tracking and show the first step
	current_step_index = 0
	_show_current_step()

func finish_quest(quest: Quest) -> void:
	print("Completed quest: %s" % quest.quest_name)
	currentQuest_label.hide()
	step_title_label.hide()
