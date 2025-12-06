extends Node
class_name BaseScene

@export var item: ItemEntity
@onready var player: Player = $Player
@onready var entrance_markers: Node2D = $EntranceMarkers
@onready var anxiety_layer = $TileMapLayer2
@onready var normal_layer = $TileMapLayer
var my_quest: Quest = preload("res://quests/get_through_the_day.tres") 
var inv: Inv = preload("res://playerInv.tres")
var instance : ItemEntity
var collected = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if SceneManager.player:
		if player:
			player.queue_free()
			print(item)
		player = SceneManager.player
		add_child(player)
		position_player()
		QuestSystem.mark_quest_as_available(my_quest)
		if QuestSystem.is_quest_available(my_quest):
			QuestSystem.start_quest(my_quest)
			instance = item.instantiate()
			inv.item_inserted.connect(new_inv_item)
			
			
func play_dialogue():
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/dialogue.dialogue"),"conversation_battle")
	
func position_player() -> void:
	for entrance in entrance_markers.get_children():
		if entrance is Marker2D and entrance.name == "any":
			player.global_position = entrance.global_position
	
func new_inv_item(new_item):
	if new_item.get_category().get_entity_name() == "items" :
		normal_layer.show()
		anxiety_layer.hide()
		play_dialogue()
		emit_signal("updated")
