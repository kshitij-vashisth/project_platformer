extends Area2D

func _reload_scene1() -> void:
	get_tree().reload_current_scene()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_body_entered(body: Node2D) -> void:
	if body.name == "MainCharacter":
		call_deferred("_reload_scene1")
	
	if body.is_in_group("enemies"):
		body.queue_free()
