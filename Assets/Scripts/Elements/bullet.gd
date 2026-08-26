extends AnimatedSprite2D
var power: int = GameManager.bullet_damage
var SPEED: int = 600
var direction: float

func _physics_process(delta: float) -> void:
	if direction < 0:
		flip_h = true
	move_local_x(direction * SPEED * delta)
	


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.health -= power
		if body.health <= 0:
			body.enemy_dead()
		queue_free()
	
	if body.is_in_group("tilemap"):
		queue_free()
