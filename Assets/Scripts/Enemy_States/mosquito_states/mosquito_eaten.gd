extends State
@export var mosquito: CharacterBody2D

func enter()->void:
	#print("mosquito in eaten state")
	mosquito.eaten_sound.play()
	mosquito.hide()
	await get_tree().create_timer(0.3).timeout
	mosquito.queue_free()
