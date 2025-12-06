class_name Headphones extends Button

@export var item: ItemEntity
var inv: Inv = preload("res://playerInv.tres")
var instance : ItemEntity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if item:
		instance = item.instantiate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	inv.insert(item)
	$".".visible = false
	$AudioStreamPlayer2D.play()
	return
