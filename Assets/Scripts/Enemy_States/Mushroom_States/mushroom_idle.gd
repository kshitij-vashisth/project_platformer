extends State

@export var mushroom: CharacterBody2D

func enter():
	print("mushroom idle")

func physics_update(delta: float) -> void:
	mushroom.add_gravity(delta)
	mushroom.move_and_slide()
