extends CharacterBody2D
@export var SPEED: float = 300.0
@export var player_bounce_velocity: float = 400.0
@export var sprite:AnimatedSprite2D
@export var ground_check: RayCast2D
@export var squash_sound: AudioStreamPlayer2D
@export var can_move: bool = true
@export var state_access: StateMachine 

var dying: bool = false
var direction: int = -1

func change_state(desired_state_name: String, state_machine):
		var current_state_name = str(state_access.current_state)
		print(current_state_name.substr(0,current_state_name.find(":")).to_lower()+"->"+desired_state_name)
		state_machine.change_state(desired_state_name)

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
	
func move_enemy()->void:
	velocity.x = SPEED * direction
	sprite.animation = "run"
	
func platform_edge()->void:
	if not ground_check.is_colliding():
		direction = -direction
		ground_check.position.x *= -1
		sprite.scale.x *= -1

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name=="MainCharacter":
		var y_delta = position.y - body.position.y
		if y_delta > 30:
			dying = true
			print("Destroy enemy")
			body.velocity.y += -player_bounce_velocity
			squash()
			await get_tree().create_timer(0.2).timeout
			queue_free()
			
		#print("Collision")
		#print(y_delta)
