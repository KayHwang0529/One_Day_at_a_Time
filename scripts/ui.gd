var quest_log = "res://addons/quest_system/gui/GUI.gd"

func _ready():
	# Connect signals for quest updates
	QuestSystem.quest_accepted.connect(update_quest_ui)
	QuestSystem.quest_completed.connect(update_quest_ui)

	# Initial UI population
	update_quest_ui()

func update_quest_ui():
	# Clear existing quests in the UI
	quest_log.clear()

	# Get active quests
	var active_quests = QuestSystem.get_active_quests()

	# Add each active quest to the UI
	for quest in active_quests:
		var label = Label.new()
		label.text = "• " + quest.title
		quest_log.add_child(label)
