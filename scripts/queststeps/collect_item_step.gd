class_name CollectItemStep extends QuestStep

@export var item: ItemEntity 
var collected = false
var inv: Inv = preload("res://playerInv.tres")
var instance: ItemEntity

func ready() -> void:
	instance = item.instantiate()
	inv.item_inserted.connect(new_inv_item)

func is_collected():
	collected = inv.contains(item) 
	if collected:
		emit_signal("updated")

func new_inv_item(new_item):
	if new_item.get_category().get_entity_name() == "items" :
		is_collected()
		emit_signal("updated")

func meets_condition() -> bool:
	return collected
