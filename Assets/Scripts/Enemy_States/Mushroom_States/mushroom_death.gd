extends State
@export var mushroom: CharacterBody2D
@export var sprite: AnimatedSprite2D
@export var death_sound: AudioStreamPlayer2D
func enter() -> void:
	death_sound.play()
	sprite.play("death")
	await get_tree().create_timer(0.45).timeout
	mushroom.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
