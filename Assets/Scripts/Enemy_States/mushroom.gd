extends CharacterBody2D
@export var SPEED: float = 300.0
@export var player_bounce_velocity: float = 400.0
@export var sprite:AnimatedSprite2D

@export var squash_sound: AudioStreamPlayer2D

func squash() -> void:
	squash_sound.play()
	sprite.scale.y = 0.3
	sprite.position.y += 20
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
			body.velocity.y += -player_bounce_velocity
			squash()
			await get_tree().create_timer(0.2).timeout
			queue_free()
			
		#print("Collision")
		#print(y_delta)
