extends CharacterBody2D

@export var direction = -1
@export var SPEED = 300.0

@export var turn_timer = 0.0
@export var TURN_INTERVAL = 1.9

@onready var game_manager: Node = %GameManager
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

func move_enemy() -> void:
	velocity.x = SPEED * direction

func turn_around(delta: float) -> void:
	turn_timer += delta
	if turn_timer >= TURN_INTERVAL:
		turn_timer = 0.0
		direction = -direction
		animated_sprite_2d.scale.x *= -1


func _physics_process(delta: float) -> void:
	move_enemy()
	turn_around(delta)

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "MainCharacter":
		print("mosquito touched")
		GameManager.mosquito_add_points()
		queue_free()
