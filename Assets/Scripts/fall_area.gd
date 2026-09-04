extends Area2D

func _reload_scene1() -> void:
	get_tree().reload_current_scene()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "MainCharacter":
		body.change_state("dead", body.state_access)
		#call_deferred("_reload_scene1")
	
	if body.is_in_group("enemies"):
		body.queue_free()
