extends BaseScene
@onready var camera = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	camera.follow_node = player


# Called every frame. 'delta' is the elapsed time since the previous frame.
