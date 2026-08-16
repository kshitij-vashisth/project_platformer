extends State

@export var mushroom: CharacterBody2D

func physics_update(delta: float) -> void:
	if mushroom.can_move:
		mushroom.move_enemy()
	if mushroom.dying:
		mushroom.change_state("idle", mushroom.state_access)
	mushroom.add_gravity(delta)
	mushroom.platform_edge()
	mushroom.move_and_slide()
