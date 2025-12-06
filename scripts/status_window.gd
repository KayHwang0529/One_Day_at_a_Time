extends Control
class_name StatusWindow 

var isOpen: bool = false

@onready var comfort_bar = $comfort_bar
@onready var anxiety_bar = $anxiety_bar
@onready var anger_bar = $anger_bar
@onready var energy_bar = $energy_bar

@onready var inv: Inv = preload("res://playerInv.tres")
@onready var slots: Array = [$GridContainer/inv_ui_slot, $GridContainer/inv_ui_slot2, $GridContainer/inv_ui_slot3, $GridContainer/inv_ui_slot4, $GridContainer/inv_ui_slot5]

func _ready():
	inv.update.connect(update_slots)
	update_slots()
	

func is_array_effectively_empty(arr: Array) -> bool:
	for element in arr:
		if element != null:
			return false
	return true
	
func update_slots():
	if !is_array_effectively_empty(slots):
		for i in range (min(inv.items.size(), slots.size())):
			slots[i] = (inv.items[i]) 


func _process(delta: float) -> void:
	comfort_bar.value = Status.comfort
	anxiety_bar.value = Status.anxiety
	anger_bar.value = Status.anger
	energy_bar.value = Status.energy 
	update_slots()

	
func update_status():
	if !is_array_effectively_empty(slots):
		for i in range (min(inv.items.size(), slots.size())):
			if (inv.items[i] == TrenchCoat):
				Status.comfort -= 20
				Status.anxiety -= 50
			elif inv.items[i] == Headphones:
				Status.comfort +=50
				Status.anxiety -= 40 
			
func _change_color(bar):
	var sb = StyleBoxFlat.new()
	add_theme_stylebox_override("fill", sb)
	if bar.value <= 30:
		sb.bg_color = Color.RED
	elif bar.value <= 50:
		sb.bg_color = Color.YELLOW
	else:
		sb.bg_color = Color.GREEN
	
func open():
	visible = true
	isOpen = true 
func close():
	visible = false
	isOpen = false 
