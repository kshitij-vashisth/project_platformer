extends CharacterBody2D

#func _ready() -> void:
	#$Area2D.body_entered.connect(_on_area_2d_body_entered)
	#print("Area2D connected, monitoring: ", $Area2D.monitoring)

#func _process(_delta: float) -> void:
	#var bodies = $Area2D.get_overlapping_bodies()
	#if bodies.size() > 0:
		#print("Overlapping: ", bodies)

func add_gravity(delta: float) -> void:
	velocity += get_gravity() * delta
	

	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name=="MainCharacter":
		var y_delta = position.y - body.position.y
		if y_delta > 30:
			print("Destroy enemy")
			queue_free()
			body.jump()
		#print("Collision")
		#print(y_delta)
