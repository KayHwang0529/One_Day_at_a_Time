class_name Player extends CharacterBody2D
@export var speed = 400
@onready var last_action_pressed = "Idle Down"


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var inv: Inv = preload("res://playerInv.tres")
	
func get_input():
	var input_direction = Input.get_vector("Walk Left", "Walk Right", "Walk Up", "Walk Down")
	velocity = input_direction * speed
	if input_direction == Vector2(-1,0):
		animated_sprite_2d.play("Run Left ")
		last_action_pressed = "Idle Left"
	elif input_direction == Vector2(1,0):
		animated_sprite_2d.play("Run Right ")
		last_action_pressed = "Idle Right"
	elif input_direction == Vector2(0,-1):
		animated_sprite_2d.play("Run Up")
		last_action_pressed = "Idle Up"
	elif input_direction == Vector2(0,1):
		animated_sprite_2d.play("Run Down")
		last_action_pressed = "Idle Down"
	else:
		animated_sprite_2d.play(last_action_pressed)
	

func _physics_process(delta):
	get_input()
	move_and_slide()

func collect(item: ItemEntity):
	inv.insert(item)
