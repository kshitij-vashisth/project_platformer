extends State

@export var mosquito: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mosquito.move_sound.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	
	mosquito.move_enemy()
	mosquito.turn_around(delta)

	mosquito.move_and_slide()
