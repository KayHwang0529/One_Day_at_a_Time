extends CanvasLayer

@onready var status_window = $status_window


func _ready() -> void:
	status_window.close()
	status_window.update_slots()

func _input(event): 
	if event.is_action_pressed("toggle_status"):
		if status_window.isOpen:
			status_window.close()
		else:
			status_window.open()
