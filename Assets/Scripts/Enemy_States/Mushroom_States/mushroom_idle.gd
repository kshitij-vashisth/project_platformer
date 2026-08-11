extends State

@export var mushroom: CharacterBody2D

func enter():
	print("mushroom idle")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func physics_update(delta: float) -> void:
	mushroom.add_gravity(delta)
	mushroom.move_and_slide()
