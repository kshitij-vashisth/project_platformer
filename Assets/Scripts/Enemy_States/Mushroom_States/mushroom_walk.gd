extends State

@export var mushroom: CharacterBody2D

func enter():
	print("ready")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("mushroom walk")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	#if mushroom.dying:
		#mushroom.change_state("idle",state_machine)
	if mushroom.can_move:
		mushroom.move_enemy()
	mushroom.add_gravity(delta)
	mushroom.platform_edge()
	mushroom.move_and_slide()
