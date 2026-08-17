extends CharacterBody2D
@export var SPEED: float = 300.0
@export var player_bounce_velocity: float = 400.0
@export var sprite:AnimatedSprite2D
@export var ground_check: RayCast2D
@export var squash_sound: AudioStreamPlayer2D
@export var can_move: bool = true
@export var state_access: StateMachine 
@export var mushroom_points: int = 150
@onready var game_manager: Node = %GameManager

var dying: bool = false
var direction: int = -1

func change_state(desired_state_name: String, state_machine):
		var current_state_name = str(state_access.current_state)

func squash() -> void:
	squash_sound.play()
	sprite.scale.y = 0.2
	sprite.position.y += 23

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
	if body.name == "MainCharacter":
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		if y_delta > 30:
			can_move = false
			dying = true
			game_manager.points += mushroom_points
			body.velocity.y += -player_bounce_velocity
			body.jump_count = 1
			body.change_state("in_air",body.state_access)
			squash()
			await get_tree().create_timer(0.2).timeout
			queue_free()
		
		if abs(x_delta) > 0 and not dying:
			var knock_dir = sign(x_delta)  # +1 if player is to the right of mushroom, -1 if left
			if knock_dir == 0:
				knock_dir = 1 if body.isLeft else -1  # pick a default based on facing
			body.velocity.x = knock_dir * 2500
			body.change_state("hurt", body.state_access)
			game_manager.decrease_health()
		
