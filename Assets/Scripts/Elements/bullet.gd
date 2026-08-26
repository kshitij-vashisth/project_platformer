extends AnimatedSprite2D

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
		GameManager.points += body.mushroom_points
		body.queue_free()
		queue_free()
