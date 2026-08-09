extends State

@export var mushroom: CharacterBody2D

func enter():
	print("mushroom idle")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	mushroom.add_gravity(delta)
	if mushroom.is_on_floor() and not mushroom.dying:
		mushroom.change_state("walk",state_machine)
	mushroom.move_and_slide()
