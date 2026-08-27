extends CharacterBody2D

@export var gravity: float = 900.0
@export var rotation_speed: float = 10.0

var SPEED: int = 60


var direction: float
var shell = preload("res://Assets/Elements/Shell.tscn")


func _physics_process(delta: float) -> void:

	#move_local_x(direction * SPEED * delta)
	velocity.y += gravity * delta
	position += velocity * delta
	rotation += rotation_speed * delta
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		rotation = lerp_angle(rotation, 0.0, 0.2)
		velocity = velocity.bounce(collision.get_normal())/3
		
		if abs(velocity.x) < 30:
			velocity.x = 0
		
		if abs(velocity.y) < 30:
			velocity.x = 0
	


func _on_timer_timeout() -> void:
	queue_free()
