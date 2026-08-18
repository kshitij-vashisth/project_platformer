extends Node2D

func level_changer() -> void:
	GameManager.level_index += 1
	get_tree().change_scene_to_file("res://Assets/Scenes/TransitionScreens/level_transition_screen.tscn")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "MainCharacter":
		body.change_state("warp_out", body.state_access)
		#body.queue_free()
		await get_tree().create_timer(0.9).timeout
		call_deferred("level_changer")
