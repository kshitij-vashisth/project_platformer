extends AnimatedSprite2D
var power: int = GameManager.bullet_damage
var SPEED: int = 600
var direction: float
var smoke = preload("res://Assets/Elements/wall_smoke_bullet.tscn")


func _physics_process(delta: float) -> void:
	if direction < 0:
		flip_h = true
	move_local_x(direction * SPEED * delta)
	


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.health -= power
		if body.health <= 0 and body.pointsEnabled:
			#body.collider.disabled
			body.pointsEnabled = false
			body.sprite.play("death")
			body.bullet_death_sound.play()
			body.enemy_dead()
		queue_free()
	
	if body.is_in_group("tilemap"):
		var smoke_instance = smoke.instantiate() as Node2D
		smoke_instance.global_position = global_position
		get_parent().add_child(smoke_instance)
		#await get_tree().create_timer(1.0).timeout
		queue_free()
